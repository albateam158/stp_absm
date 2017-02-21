var NoticeCommon = {};
NoticeCommon.Dialog = {
	/**
	 * Dialog Id
	 */
	DialogInfo: {
		titleId: 'common-modal-title',
		okBtnId: 'common-modal-ok-btn',
		cancelBtnId: 'common-modal-cancel-btn',
	},

	/**
	 * Default Item Message
	 */
	Message: {
		title: '알림',
		ok: '확인',
		cancel: '취소'
	},

	/**
	 * Element 생성
	 *
	 * @param elementTag Element Tag
	 * @param attributeData Set Attribute Object
	 * @param appendElement AppendChild Element Object
	 * @return Element Object
	 */
	createElement: function(elementTag, attributeData, appendElement){
		// Element 생성
		var elementObj = document.createElement(elementTag);
		// Attrbute 추가
		for(var key in attributeData){
			//console.log(key, attrbutes[key]);
			elementObj.setAttribute(key, attributeData[key]);
		};
		// Element Append
		if(appendElement){
			appendElement.appendChild(elementObj);
		}

		return elementObj;
	},

	/**
	 * Modal Dialog Make
	 */
	makeModalDialog: function(data){
		// UUID 생성
		var uuid;
		if(typeof(Util) === 'object' && typeof(Util.uuid) === 'function'){
			uuid = Util.uuid();
		}else{
			uuid = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
				var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
				return v.toString(16);
			});
		}

		// Dialog Id
		data.dialogId = 'common-modal-dialog-' + data.dialogType + '-' + uuid;

		/***************************************************************************/
		// ---------------- Modal Main Div ----------------
		var modalDiv = this.createElement('div'
			, {'id': data.dialogId,'class': 'modal fade disable-scroll','tabindex': '-1','role': 'dialog','aria-labelledby': this.DialogInfo.titleId,'aria-hidden': 'true'}
			, document.body);
		var modalDialogDiv = this.createElement('div', {'class': 'modal-dialog modal-sm'}, modalDiv);
		var modalContentWrapperDiv = this.createElement('div', {'class': 'modal-content-wrapper'}, modalDialogDiv);
		var modalContentDiv = this.createElement('div', {'class': 'modal-content'}, modalContentWrapperDiv);

		// ---------------- Modal Header ----------------
		var modalHeaderDiv = this.createElement('div', {'class': 'modal-header'}, modalContentDiv);

		//Close Header
		if(data.headerCloseBtn) {
		         var modalHeaderCloseBtn = this.createElement('button', {'type': 'button', 'class': 'close', 'data-dismiss': 'modal', 'aria-hidden': 'true'}, modalHeaderDiv);
		         modalHeaderCloseBtn.innerHTML ='<img src="/images/btn_close.png">';
		}

		// title
		if(data.dialogType == 'complete'){
			var modalHeaderTitle = this.createElement('h2', {'class': 'modal-title top', 'id': this.DialogInfo.titleId}, modalHeaderDiv);
			//var modalHeaderIco = this.createElement('p', {'class': 'ic_completion', 'id': this.DialogInfo.titleId}, modalHeaderDiv);
		} else {
			var modalHeaderTitle = this.createElement('h2', {'class': 'modal-title top fail', 'id': this.DialogInfo.titleId}, modalHeaderDiv);
			//var modalHeaderIco = this.createElement('p', {'class': 'ic_fail', 'id': this.DialogInfo.titleId}, modalHeaderDiv);
		}

		modalHeaderTitle.innerHTML = data.title ? data.title : this.Message.title;

		// ---------------- Modal Body ----------------
		var modalBodyDiv = this.createElement('div', {'class': 'modal-body t-c', 'style': 'word-break: break-all'}, modalContentDiv);;
		modalBodyDiv.innerHTML = data.content ? data.content : '';

		// ---------------- Modal Footer ----------------
		var modalFooterDiv = this.createElement('div', {'class': 'modal-footer t-c'}, modalContentDiv);
		var modalFooterUl = this.createElement('ul', {'class': 'modal-footer-list'}, modalFooterDiv);

		// Cancle Button
		if(data.dialogType == 'confirm'){
			var modalFooterLi = this.createElement('li', {'class': 'pull-left fl t-r'}, modalFooterUl);
			var modalFooterCancleBtn = this.createElement('button', {'type': 'button', 'class': 'btn_type02 dark', 'data-dismiss': 'modal', 'id': this.DialogInfo.cancelBtnId}, modalFooterLi);
			modalFooterCancleBtn.innerHTML = data.cancel ? data.cancel : this.Message.cancel;
			var modalFooterLi = this.createElement('li', {'class': 'pull-left fr t-l'}, modalFooterUl);
			var modalFooterOkAttr = {'type': 'button', 'class': 'btn_type03', 'id': this.DialogInfo.okBtnId};
		} else {
			var modalFooterOkAttr = {'type': 'button', 'class': 'btn_type03', 'id': this.DialogInfo.okBtnId};
			var modalFooterLi = this.createElement('li', {'class': ''}, modalFooterUl);
		}
		
		if(data.dialogType == 'alert'){
			// Ok Button
			modalFooterOkAttr['data-dismiss'] = 'modal';
		}
		var modalFooterOkBtn = this.createElement('button', modalFooterOkAttr, modalFooterLi);
		modalFooterOkBtn.innerHTML = data.okTxt ? data.okTxt : this.Message.ok;
		//modalFooterOkBtn.innerHTML = this.Message.ok;
		/***************************************************************************/
		// Modal Default option Setting
		var modalOption = {
			keyboard: false // ESC 키 눌렀을때 모달을 닫음
			,backdrop: 'static' // 모달의 배경을 포함. 클릭 시 모달을 닫지 않을 시 'static'
			,show: false // 초기화 시 모달을 보여줍니다.
		}
		// 사용자 지정 정보 설정
		$.extend(modalOption, data);

		// Jquery Dialog 변수 선언
		var dialog = $('#' + data.dialogId);

		// Bootstrap Modal Setting
		dialog.modal(modalOption)

		// Modal의 hide가 완료된 이후 Event 실행
		dialog.on('hidden.bs.modal', function(e){
			// Modal Element 제거
			dialog.remove();
		});

		if(data.dialogType == 'alert' || data.dialogType == 'complete'){
			dialog.find(" #" + this.DialogInfo.okBtnId).on('click', function(){
				// ok button event function 실행
				if(data.ok && typeof(data.ok) === 'function'){
					data.ok();
				}

				// Modal 창 닫기
				dialog.modal('hide');

				// click enevt 제거
				$(this).off('click');
			});
		}

		// Confirm 일 경우 확인 버튼 클릭 이벤트 지정
		if(data.dialogType == 'confirm'){
			dialog.find(" #" + this.DialogInfo.okBtnId).on('click', function(){
				// ok button event function 실행
				if(data.ok && typeof(data.ok) === 'function'){
					data.ok();
				}else{
					console.warn('not function ok event. dialogId: ' + data.dialogId);
				}

				// Modal 창 닫기
				dialog.modal('hide');
				// click enevt 제거
				$(this).off('click');
			});

			dialog.find(" #" + this.DialogInfo.cancelBtnId).on('click', function(){
				// ok button event function 실행
				if(data.again && typeof(data.again) === 'function'){
					data.again();
				}else{
					console.warn('not function again event. dialogId: ' + data.dialogId);
				}

				// Modal 창 닫기
				dialog.modal('hide');
				// click enevt 제거
				$(this).off('click');
			});
		}

		// Modal Dialog Show
		dialog.modal('show');
	},

	/**
	 * Modal Dialog Show
	 */
	show: function(type, data){
		if(!data){data = {};}
		data.dialogType = type ? type : 'alert';
		this.makeModalDialog(data);
	},

	/**
	 * Alert Modal Dialog
	 *
	 * data:
	 *  title: Dialog Title Message
	 *  content: Dialog Content Message
	 *  closeBtn: Header Close Btn(x)
	 *
	 */
	alert: function(data){
		// data가 Object 가 아닌 경우 content 로 설정한다.
		if(typeof(data) != 'object'){
			var content = data;
			data = {content: content};
		}
		this.show('alert', data);
	},

	complete: function(data){
		// data가 Object 가 아닌 경우 content 로 설정한다.
		if(typeof(data) != 'object'){
			var content = data;
			data = {content: content};
		}
		this.show('complete', data);
	},

	/**
	 * Confirm Modal Dialog
	 *
	 * data:
	 *  title: Dialog Title Message
	 *  content: Dialog Content Message
	 *  ok: Ok Button Click Event function
	 *  closeBtn: Header Close Btn(x)
	 *
	 */
	confirm: function(data){
		this.show('confirm', data);
	}
};

+function ($) {
	'use strict';

	// MODAL CLASS DEFINITION
	// ======================

	var Modal = function (element, options) {
		this.options             = options
		this.$body               = $(document.body)
		this.$element            = $(element)
		this.$dialog             = this.$element.find('.modal-dialog')
		this.$backdrop           = null
		this.isShown             = null
		this.originalBodyPad     = null
		this.scrollbarWidth      = 0
		this.ignoreBackdropClick = false

		if (this.options.remote) {
			this.$element
				.find('.modal-content')
				.load(this.options.remote, $.proxy(function () {
					this.$element.trigger('loaded.bs.modal')
				}, this))
		}
	}

	Modal.VERSION  = '3.3.4'

	Modal.TRANSITION_DURATION = 300
	Modal.BACKDROP_TRANSITION_DURATION = 150

	Modal.DEFAULTS = {
		backdrop: true,
		keyboard: true,
		show: true
	}

	Modal.prototype.toggle = function (_relatedTarget) {
		return this.isShown ? this.hide() : this.show(_relatedTarget)
	}

	Modal.prototype.show = function (_relatedTarget) {
		var that = this
		var e    = $.Event('show.bs.modal', { relatedTarget: _relatedTarget })

		this.$element.trigger(e)

		if (this.isShown || e.isDefaultPrevented()) return

		this.isShown = true

		this.checkScrollbar()
		this.setScrollbar()
		this.$body.addClass('modal-open')

		this.escape()
		this.resize()

		this.$element.on('click.dismiss.bs.modal', '[data-dismiss="modal"]', $.proxy(this.hide, this))

		this.$dialog.on('mousedown.dismiss.bs.modal', function () {
			that.$element.one('mouseup.dismiss.bs.modal', function (e) {
				if ($(e.target).is(that.$element)) that.ignoreBackdropClick = true
			})
		})

		this.backdrop(function () {
			var transition = $.support.transition && that.$element.hasClass('fade')

			if (!that.$element.parent().length) {
				that.$element.appendTo(that.$body) // don't move modals dom position
			}

			that.$element
				.show()
				.scrollTop(0)

			that.adjustDialog()

			if (transition) {
				that.$element[0].offsetWidth // force reflow
			}

			that.$element
				.addClass('in')
				.attr('aria-hidden', false)

			that.enforceFocus()

			var e = $.Event('shown.bs.modal', { relatedTarget: _relatedTarget })

			transition ?
				that.$dialog // wait for modal to slide in
					.one('bsTransitionEnd', function () {
						that.$element.trigger('focus').trigger(e)
					})
					.emulateTransitionEnd(Modal.TRANSITION_DURATION) :
				that.$element.trigger('focus').trigger(e)
		})
	}

	Modal.prototype.hide = function (e) {
		if (e) e.preventDefault()

		e = $.Event('hide.bs.modal')

		this.$element.trigger(e)

		if (!this.isShown || e.isDefaultPrevented()) return

		this.isShown = false

		this.escape()
		this.resize()

		$(document).off('focusin.bs.modal')

		this.$element
			.removeClass('in')
			.attr('aria-hidden', true)
			.off('click.dismiss.bs.modal')
			.off('mouseup.dismiss.bs.modal')

		this.$dialog.off('mousedown.dismiss.bs.modal')

		$.support.transition && this.$element.hasClass('fade') ?
			this.$element
				.one('bsTransitionEnd', $.proxy(this.hideModal, this))
				.emulateTransitionEnd(Modal.TRANSITION_DURATION) :
			this.hideModal()
	}

	Modal.prototype.enforceFocus = function () {
		$(document)
			.off('focusin.bs.modal') // guard against infinite focus loop
			.on('focusin.bs.modal', $.proxy(function (e) {
				if (this.$element[0] !== e.target && !this.$element.has(e.target).length) {
					this.$element.trigger('focus')
				}
			}, this))
	}

	Modal.prototype.escape = function () {
		if (this.isShown && this.options.keyboard) {
			this.$element.on('keydown.dismiss.bs.modal', $.proxy(function (e) {
				e.which == 27 && this.hide()
			}, this))
		} else if (!this.isShown) {
			this.$element.off('keydown.dismiss.bs.modal')
		}
	}

	Modal.prototype.resize = function () {
		if (this.isShown) {
			$(window).on('resize.bs.modal', $.proxy(this.handleUpdate, this))
		} else {
			$(window).off('resize.bs.modal')
		}
	}

	Modal.prototype.hideModal = function () {
		var that = this
		this.$element.hide()
		this.backdrop(function () {
			that.$body.removeClass('modal-open')
			that.resetAdjustments()
			that.resetScrollbar()
			that.$element.trigger('hidden.bs.modal')
		})
	}

	Modal.prototype.removeBackdrop = function () {
		this.$backdrop && this.$backdrop.remove()
		this.$backdrop = null
	}

	Modal.prototype.backdrop = function (callback) {
		var that = this
		var animate = this.$element.hasClass('fade') ? 'fade' : ''

		if (this.isShown && this.options.backdrop) {
			var doAnimate = $.support.transition && animate

			this.$backdrop = $('<div class="modal-backdrop ' + animate + '" />')
				.appendTo(this.$body)

			this.$element.on('click.dismiss.bs.modal', $.proxy(function (e) {
				if (this.ignoreBackdropClick) {
					this.ignoreBackdropClick = false
					return
				}
				if (e.target !== e.currentTarget) return
				this.options.backdrop == 'static'
					? this.$element[0].focus()
					: this.hide()
			}, this))

			if (doAnimate) this.$backdrop[0].offsetWidth // force reflow

			this.$backdrop.addClass('in')

			if (!callback) return

			doAnimate ?
				this.$backdrop
					.one('bsTransitionEnd', callback)
					.emulateTransitionEnd(Modal.BACKDROP_TRANSITION_DURATION) :
				callback()

		} else if (!this.isShown && this.$backdrop) {
			this.$backdrop.removeClass('in')

			var callbackRemove = function () {
				that.removeBackdrop()
				callback && callback()
			}
			$.support.transition && this.$element.hasClass('fade') ?
				this.$backdrop
					.one('bsTransitionEnd', callbackRemove)
					.emulateTransitionEnd(Modal.BACKDROP_TRANSITION_DURATION) :
				callbackRemove()

		} else if (callback) {
			callback()
		}
	}

	// these following methods are used to handle overflowing modals

	Modal.prototype.handleUpdate = function () {
		this.adjustDialog()
	}

	Modal.prototype.adjustDialog = function () {
		var modalIsOverflowing = this.$element[0].scrollHeight > document.documentElement.clientHeight

		this.$element.css({
			paddingLeft:  !this.bodyIsOverflowing && modalIsOverflowing ? this.scrollbarWidth : '',
			paddingRight: this.bodyIsOverflowing && !modalIsOverflowing ? this.scrollbarWidth : ''
		})
	}

	Modal.prototype.resetAdjustments = function () {
		this.$element.css({
			paddingLeft: '',
			paddingRight: ''
		})
	}

	Modal.prototype.checkScrollbar = function () {
		var fullWindowWidth = window.innerWidth
		if (!fullWindowWidth) { // workaround for missing window.innerWidth in IE8
			var documentElementRect = document.documentElement.getBoundingClientRect()
			fullWindowWidth = documentElementRect.right - Math.abs(documentElementRect.left)
		}
		this.bodyIsOverflowing = document.body.clientWidth < fullWindowWidth
		this.scrollbarWidth = this.measureScrollbar()
	}

	Modal.prototype.setScrollbar = function () {
		var bodyPad = parseInt((this.$body.css('padding-right') || 0), 10)
		this.originalBodyPad = document.body.style.paddingRight || ''
		if (this.bodyIsOverflowing) this.$body.css('padding-right', bodyPad + this.scrollbarWidth)
	}

	Modal.prototype.resetScrollbar = function () {
		this.$body.css('padding-right', this.originalBodyPad)
	}

	Modal.prototype.measureScrollbar = function () { // thx walsh
		var scrollDiv = document.createElement('div')
		scrollDiv.className = 'modal-scrollbar-measure'
		this.$body.append(scrollDiv)
		var scrollbarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth
		this.$body[0].removeChild(scrollDiv)
		return scrollbarWidth
	}


	// MODAL PLUGIN DEFINITION
	// =======================

	function Plugin(option, _relatedTarget) {
		return this.each(function () {
			var $this   = $(this)
			var data    = $this.data('bs.modal')
			var options = $.extend({}, Modal.DEFAULTS, $this.data(), typeof option == 'object' && option)

			if (!data) $this.data('bs.modal', (data = new Modal(this, options)))
			if (typeof option == 'string') data[option](_relatedTarget)
			else if (options.show) data.show(_relatedTarget)
		})
	}

	var old = $.fn.modal

	$.fn.modal             = Plugin
	$.fn.modal.Constructor = Modal


	// MODAL NO CONFLICT
	// =================

	$.fn.modal.noConflict = function () {
		$.fn.modal = old
		return this
	}


	// MODAL DATA-API
	// ==============

	$(document).on('click.bs.modal.data-api', '[data-toggle="modal"]', function (e) {
		var $this   = $(this)
		var href    = $this.attr('href')
		var $target = $($this.attr('data-target') || (href && href.replace(/.*(?=#[^\s]+$)/, ''))) // strip for ie7
		var option  = $target.data('bs.modal') ? 'toggle' : $.extend({ remote: !/#/.test(href) && href }, $target.data(), $this.data())

		if ($this.is('a')) e.preventDefault()

		$target.one('show.bs.modal', function (showEvent) {
			if (showEvent.isDefaultPrevented()) return // only register focus restorer if modal will actually get shown
			$target.one('hidden.bs.modal', function () {
				$this.is(':visible') && $this.trigger('focus')
			})
		})
		Plugin.call($target, option, this)
	})

}(jQuery);