const FILL_VIEW  = -1;
const FILL_COLUMN = -2;
const CUSTOM_HEIGHT = -1;

const HIT_TEST_NONE = -1;
const HIT_TEST_RIGHT_CENTER = 0;
const HIT_TEST_RIGHT_BOTTOM = 1;
const HIT_TEST_CENTER_BOTTOM = 2;
const HIT_TEST_CENTER = 3;

const XEditorItemTypeText = 0;
const XEditorItemTypeImage = 1;
const XEditorItemTypeVideo = 2;
const XEditorItemTypeYoutube = 10;
const XEditorItemTypeLink = 11;

const ContextMenuTypeTextStyle = 1;
const ContextMenuTypeTextAlign = 2;
const ContextMenuTypeTextSize = 3;
const ContextMenuTypeTextColor = 4;

const XEditorItemTextStyleNormal = 0;
const XEditorItemTextStyleHeader = 1;
const XEditorItemTextStyleQuote = 2;

const XEditorItemTextAlignLeft = 0;
const XEditorItemTextAlignCenter = 1;
const XEditorItemTextAlignRight = 2;


var hexDigits = new Array
("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");

//Function to convert hex format to a rgb color
function rgb2hex(rgb) {
    rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
    return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
}

function hex(x) {
    return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
}

function Rect(left, top, right, bottom) {

    this.left = left;
    this.top = top;
    this.right = right;
    this.bottom = bottom;
}

Rect.prototype.width = function() {
    return this.right - this.left;
}

Rect.prototype.height = function() {
    return this.bottom - this.top;
}

Rect.prototype.contains = function(x, y) {

    return this.left < x && this.right > x && this.top < y && this.bottom > y;
}

Rect.prototype.intersectRect = function(frame) {
    return this.left < frame.right && frame.left < this.right && this.top < frame.bottom && frame.top < this.bottom
}

function XEditorItem() {

    this.itemId = 0;
    this.position = 0;
    this.type = 0;
    this.column = 0;
    this.row = 0;
    this.text = "";
    this.textAlign = 0;
    this.textStyle = 0;
    this.textSize = 1.0;
    this.textColor = 0xff000000;
    this.contentUrl = "";
    this.mediaWidth = 0;
    this.mediaHeight = 0;
    this.scale = 1;
    this.offsetX = 0.5;
    this.offsetY = 0.5;
    this.selected = false;
    this.editing = false;
    this.hitTestResult = HIT_TEST_NONE;
    this.placeholder = null;
    this.cell = null;
    this.complete = false;
    this.resizeable = true;
}

function createCORSRequest(method, url) {
    var xhr = new XMLHttpRequest();
    if ("withCredentials" in xhr) {

        // Check if the XMLHttpRequest object has a "withCredentials" property.
        // "withCredentials" only exists on XMLHTTPRequest2 objects.
        xhr.open(method, url, true);

    } else if (typeof XDomainRequest != "undefined") {

        // Otherwise, check if XDomainRequest.
        // XDomainRequest only exists in IE, and is IE's way of making CORS requests.
        xhr = new XDomainRequest();
        xhr.open(method, url);

    } else {

        // Otherwise, CORS is not supported by the browser.
        xhr = null;

    }
    return xhr;
}

XEditorItem.prototype.setSelected = function(selected) {

    if(this.selected != selected) {
        this.selected = selected;

        this.showBorder(this.selected);
        this.showResizeHandle(this.selected);

        if(this.selected) {
            this.cell.removeClass("z_low");
            this.cell.removeClass("z_normal")
            this.cell.addClass("z_high");
        } else {
            this.cell.removeClass("z_low");
            this.cell.addClass("z_normal");
            this.cell.removeClass("z_high");
        }
    }
}

XEditorItem.prototype.setEditing = function(editing) {

    if(this.editing != editing) {

        this.editing = editing;

        if(XEditorItemTypeText == this.type || XEditorItemTypeLink == this.type) {
            if(this.editing) {
                this.cell.find(".text").removeAttr("disabled");
                this.cell.find(".xe_content").focus();
                this.showResizeHandle(false);
            } else {
                this.cell.find(".text").attr("disabled", "");
                this.showResizeHandle(true);
            }
        } else if(XEditorItemTypeImage == this.type) {

            if(this.editing) {

                this.cell.addClass("z-high");
                this.cell.find(".content_container").removeClass("crop");
                this.showResizeHandle(false);
                this.cell.find("[name='incZoom']").show();
                this.cell.find("[name='decZoom']").show();

                this.repositionClipRect();

                var html = $("<img name='temp' style='opacity:0.2' class='xe_content bg_gray' src='" + this.contentUrl + "'/>");
                html.css("left", this.cell.find(".xe_content").css("left"));
                html.css("top", this.cell.find(".xe_content").css("top"));
                html.width(this.cell.find(".xe_content").width());
                html.height(this.cell.find(".xe_content").height());

                this.cell.find(".content_container").prepend(html);


            } else {

                this.cell.find(".content_container").addClass("crop");
                this.cell.find("[name='content']").css("clip", "auto");
                this.cell.find("[name='incZoom']").hide();
                this.cell.find("[name='decZoom']").hide();
                this.cell.find("[name=temp]").remove();
            }
        }
    }
}

XEditorItem.prototype.showBorder = function(show) {

    if(show) {
        this.cell.find(".border").removeClass("hidden");
    } else {
        this.cell.find(".border").addClass("hidden");
    }
}

XEditorItem.prototype.showResizeHandle = function(show) {

    if(show && this.resizeable) {
        this.cell.find(".resize_container").removeClass("hidden");
    } else {
        this.cell.find(".resize_container").addClass("hidden");
    }
}

XEditorItem.prototype.repositionClipRect = function() {

    var containerWidth = this.cell.find(".content_container").width();
    var containerHeight = this.cell.find(".content_container").height();

    var content = this.cell.find("[name='content']");

    var top = -parseInt(content.css("top")) + "px";
    var right = -parseInt(content.css("left")) + containerWidth + "px";
    var bottom = -parseInt(content.css("top")) + containerHeight + "px";
    var left =  -parseInt(content.css("left")) + "px";

    content.css("clip", "rect(" + top + ", " + right + "," + bottom + "," + left +")");
}

XEditorItem.prototype.hitTest = function(x, y) {

    if(this.resizeable == false) {
        return HIT_TEST_CENTER;
    }

    //return HIT_TEST_RIGHT_CENTER;

    // 오른쪽 핸들
    var rightHandle = new Rect();
    rightHandle.left = this.frame.width() - 20;
    rightHandle.top = (this.frame.height() / 2) - 10;
    rightHandle.right = rightHandle.left + 20;
    rightHandle.bottom = rightHandle.top + 20;

    if(rightHandle.contains(x, y)) {
        return HIT_TEST_RIGHT_CENTER;
    }

    // 오른쪽 아래 핸들
    var rightBottomHandle = new Rect();
    rightBottomHandle.left = this.frame.width() - 20;
    rightBottomHandle.top = this.frame.height() - 20;
    rightBottomHandle.right = rightBottomHandle.left + 20;
    rightBottomHandle.bottom = rightBottomHandle.top + 20;

    if(rightBottomHandle.contains(x, y)) {
        return HIT_TEST_RIGHT_BOTTOM;
    }

    // 아래쪽 핸들
    var bottomHandle = new Rect();
    bottomHandle.left = (this.frame.width() / 2) - 10
    bottomHandle.top = this.frame.height() - 20;
    bottomHandle.right = bottomHandle.left + 20;
    bottomHandle.bottom = bottomHandle.top + 20;

    if(bottomHandle.contains(x, y)) {
        return HIT_TEST_CENTER_BOTTOM;
    }

    return HIT_TEST_CENTER;
}

function XEditor(parent) {

    // 컨테이너 생성
    this.container = $("<div></div>");
    $(parent).append(this.container);

    this.editing = false;
    this.columns = 3;
    this.horizontalSpacing = 30;
    this.verticalSpacing = 30;
    this.items = new Array();
    this.selectedItem = null;
    this.minBlockWidth = 0;

    this.animating = false;
    this.pvTouchX = 0;
    this.pvTouchY = 0;

    this.coverUrl = null;
    this.coverWidth = 0;
    this.coverHeight = 0;
    this.coverScale = 1;
    this.coverOffsetX = 0.5;
    this.coverOffsetY = 0.5;
    this.contextMenu = null;
}

XEditor.prototype.addItem = function(object) {

    var item = new XEditorItem();
    for(var property in object) {
        item[property] = object[property];
    }

    this.hideContextMenu();


    if(!item.itemId) {
        item.itemId = Math.floor((Math.random() * 100000) + 1);
    }

    if(this.editing && this.selectedItem) {
        var index = this.indexForItem(this.selectedItem);
        this.items.splice(index + 1, 0, item);
    } else {
        this.items.push(item);
    }

    var instance = this;

    if(item.file) {

        var formData = new FormData();
        formData.append("file", item.file);

        var xUpload = new XUpload();
        var uploadResult = xUpload.crossUpload(formData, function (data) {
            item.contentUrl = data.url;
            item.mediaWidth = data.width;
            item.mediaHeight = data.height;
            item.complete = true;

            if(XEditorItemTypeImage == item.type) {
                item.cell.find(".xe_content").attr("src", item.contentUrl);
                //item.cell.find(".fill").removeClass("loading");
            } else if(XEditorItemTypeVideo == item.type) {
                item.cell.find("xe_content > source").attr("src", item.contentUrl);
                item.cell.find("video")[0].load();
            }

            // 레이아웃 갱신
            instance.measure();
            instance.layout();
        });

    } else {
        item.complete = true;
    }

    // 레이아웃 갱신
    this.measure();
    this.layout();

    if(this.editing && this.selectedItem) {

        if(this.selectedItem) {
            this.selectedItem.setSelected(false);
            this.selectedItem.setEditing(false);
        }
        this.selectedItem = item;
        this.selectedItem.setSelected(true);
        if(XEditorItemTypeText == this.selectedItem.type) {
            this.selectedItem.setEditing(true);
        }

        // 스크롤 위치 변경
        var offset = item.cell.offset().top - $(window).scrollTop();

        if(offset > window.innerHeight){
            // Not in view so scroll to it
            $('html,body').animate({scrollTop: offset}, 200);
        }
    }
}

XEditor.prototype.addItems = function(items) {

    for(var i = 0 ; i < items.length ; i++) {
        this.addItem(item);
    }
}

XEditor.prototype.init = function() {



    var instance = this;

    $(document).on("mousedown", function(e) {
        if(!instance.clickProcess) {
            if(instance.selectedItem && instance.selectedItem.editing) {
                instance.selectedItem.setEditing(false);
                instance.hideContextMenu();
            }
        }
    });

    // 컨텍스트 메뉴
    $(document).on("click", "#ico_editing", function() {
        instance.hideContextMenu();
        instance.selectedItem.setEditing(true);
    });

    $(document).on("click", "#ico_style", function() {
        instance.hideContextMenu();
        instance.showContextMenu(instance.selectedItem, ContextMenuTypeTextStyle);
    });

    $(document).on("click", "#ico_text_style_normal", function() {
        instance.hideContextMenu();
        instance.selectedItem.textStyle = XEditorItemTextStyleNormal;
        instance.selectedItem.cell.find(".text").addClass("text_normal");
        instance.selectedItem.cell.find(".text").removeClass("text_header");
        instance.selectedItem.cell.find(".text").removeClass("text_quote");

        instance.measure();
        instance.layout();

        instance.showContextMenu(instance.selectedItem);
    });

    $(document).on("click", "#ico_text_style_header", function() {
        instance.hideContextMenu();
        instance.selectedItem.textStyle = XEditorItemTextStyleHeader;
        instance.selectedItem.cell.find(".text").removeClass("text_normal");
        instance.selectedItem.cell.find(".text").addClass("text_header");
        instance.selectedItem.cell.find(".text").removeClass("text_quote");


        instance.measure();
        instance.layout();

        instance.showContextMenu(instance.selectedItem);
    });

    $(document).on("click", "#ico_text_style_quote", function() {
        instance.hideContextMenu();
        instance.selectedItem.textStyle = XEditorItemTextStyleQuote;
        instance.selectedItem.cell.find(".text").removeClass("text_normal");
        instance.selectedItem.cell.find(".text").removeClass("text_header");
        instance.selectedItem.cell.find(".text").addClass("text_quote");


        instance.measure();
        instance.layout();

        instance.showContextMenu(instance.selectedItem);
    });

    $(document).on("click", "#ico_align", function() {
        instance.hideContextMenu();
        instance.showContextMenu(instance.selectedItem, ContextMenuTypeTextAlign);
    });

    $(document).on("click", "#ico_text_align_left", function() {
        instance.selectedItem.textAlign = XEditorItemTextAlignLeft;
        instance.selectedItem.cell.find(".text").addClass("text_left");
        instance.selectedItem.cell.find(".text").removeClass("text_center");
        instance.selectedItem.cell.find(".text").removeClass("text_right");
    });

    $(document).on("click", "#ico_text_align_center", function() {
        instance.selectedItem.textAlign = XEditorItemTextAlignCenter;
        instance.selectedItem.cell.find(".text").removeClass("text_left");
        instance.selectedItem.cell.find(".text").addClass("text_center");
        instance.selectedItem.cell.find(".text").removeClass("text_right");
    });

    $(document).on("click", "#ico_text_align_right", function() {
        instance.selectedItem.textAlign = XEditorItemTextAlignRight;
        instance.selectedItem.cell.find(".text").removeClass("text_left");
        instance.selectedItem.cell.find(".text").removeClass("text_center");
        instance.selectedItem.cell.find(".text").addClass("text_right");
    });

    $(document).on("click", "#ico_size", function() {
        instance.hideContextMenu();
        instance.showContextMenu(instance.selectedItem, ContextMenuTypeTextSize);
    });

    $(document).on("click", "#ico_text_size_down", function() {



        if(instance.selectedItem.textSize > 10) {
            instance.selectedItem.textSize -= 1;
            $("#text-size").html(instance.selectedItem.textSize+'px');
            instance.selectedItem.cell.find(".text").css("font-size", instance.selectedItem.textSize + "px");
            instance.measure();
            instance.layout();
        }


    });

    $(document).on("click", "#ico_text_size_up", function() {

        instance.selectedItem.textSize += 1;

        $("#text-size").html(instance.selectedItem.textSize+'px');
        instance.selectedItem.cell.find(".text").css("font-size", instance.selectedItem.textSize + "px");
        instance.measure();
        instance.layout();
    });

    $(document).on("click", "#ico_color", function() {
        instance.hideContextMenu();
        instance.showContextMenu(instance.selectedItem, ContextMenuTypeTextColor);
    });

    $(document).on("click", "[data-id='ico_text_color']", function() {
        var color = rgb2hex($(this).css("background-color"));
        instance.selectedItem.textColor = color;
        instance.selectedItem.cell.find(".text").css("color", color);
    });

    $(document).on("click", "#ico_crop", function() {
        instance.hideContextMenu();
        instance.selectedItem.setEditing(true);
    });

    // 삭제
    $(document).on("click", "#ico_delete", function() {
        instance.hideContextMenu();
        instance.removeItem(instance.selectedItem);
    });

    $(document).on("click", "#ico_menu_cancel", function() {
        instance.hideContextMenu();
        instance.showContextMenu(instance.selectedItem);
    });

    $(document).keyup(function(e) {

        if(instance.editing &&
            instance.selectedItem &&
            1 < instance.items.length) {

            if(!instance.selectedItem.editing) {
                var needsLayout = false;
                var selectedItem = instance.selectedItem;
                var index = instance.indexForItem(selectedItem);

                if(13 == e.keyCode) {
                    // 엔터
                    instance.selectedItem.setEditing(true);
                    instance.hideContextMenu();
                } else if(27 == e.keyCode) {
                    // ESC
                    instance.hideContextMenu();
                    instance.showContextMenu(instance.selectedItem);
                } else if((37 == e.keyCode || 38 == e.keyCode) && 0 < index && e.shiftKey) {
                    var swapItem = instance.items[index - 1];
                    instance.items[index - 1] = selectedItem;
                    instance.items[index] = swapItem;
                    needsLayout = true;
                } else if((39 == e.keyCode || 40 == e.keyCode) && index + 1 < instance.items.length && e.shiftKey) {
                    var swapItem = instance.items[index + 1];
                    instance.items[index + 1] = selectedItem;
                    instance.items[index] = swapItem;
                    needsLayout = true;
                } else if((37 == e.keyCode || 38 == e.keyCode) && 0 < index) {
                    var swapItem = instance.items[index - 1];
                    swapItem.setSelected(true);
                    instance.selectedItem.setSelected(false);
                    instance.selectedItem = swapItem;

                    instance.hideContextMenu();
                    instance.showContextMenu(instance.selectedItem);
                } else if((39 == e.keyCode || 40 == e.keyCode) && index + 1 < instance.items.length) {
                    var swapItem = instance.items[index + 1];
                    swapItem.setSelected(true);
                    instance.selectedItem.setSelected(false);
                    instance.selectedItem = swapItem;

                    instance.hideContextMenu();
                    instance.showContextMenu(instance.selectedItem);

                } else if(8 == e.keyCode && e.shiftKey) {

                    instance.removeItem(instance.selectedItem);
                    instance.selectedItem = null;

                    instance.hideContextMenu();
                    needsLayout = true;
                }

                if(needsLayout) {

                    instance.hideContextMenu();

                    instance.animating = true;
                    instance.measure();

                    for(var i = 0 ; i < instance.items.length ; i++) {

                        var item = instance.items[i];

                        instance.animatePlaceholderToFrame(item);
                        instance.animateItemToFrame(item);
                    }

                    setTimeout(function() {
                        instance.swapping = false;
                        instance.animating = false;
                        instance.showContextMenu(instance.selectedItem);
                    }, 300);
                }
            } else {

                if(27 == e.keyCode) {
                    // ESC
                    instance.showContextMenu(instance.selectedItem);
                    instance.selectedItem.setSelected(true);
                    instance.selectedItem.setEditing(false);
                }
            }

        }
    });

    $(document).on("mousedown", "div.cell", function(e) {

        if(0 < e.button) {
            instance.clickProcess = false;
            return;
        }

        if(instance.editing) {
            var currentItem = instance.itemForCell(e.currentTarget);

            if(instance.selectedItem && currentItem.itemId != instance.selectedItem.itemId) {
                instance.selectedItem.setSelected(false);
                instance.selectedItem.setEditing(false);
                instance.hideContextMenu();
            }

            instance.selectedItem = currentItem;
            instance.selectedItem.setSelected(true);
            instance.selectedItem.hitTestResult = instance.selectedItem.hitTest(e.offsetX, e.offsetY);

            instance.pvTouchX = e.pageX;
            instance.pvTouchY = e.pageY;

            if(!instance.selectedItem.editing) {
                if(!instance.contextMenu) {
                    // 컨텍스트 메뉴
                    instance.showContextMenu(instance.selectedItem);
                }
            }

            //return false;

            instance.clickProcess = true;
        }


    }).on("mousemove", function(e) {

        if(instance.selectedItem && instance.selectedItem.hitTestResult != HIT_TEST_NONE) {

            instance.hideContextMenu();

            var distanceX = e.pageX - instance.pvTouchX;
            var distanceY = e.pageY - instance.pvTouchY;
            var currentLeft = parseInt(instance.selectedItem.cell.css("left"));
            var currentTop = parseInt(instance.selectedItem.cell.css("top"));

            instance.pvTouchX = e.pageX;
            instance.pvTouchY = e.pageY;

            if(instance.selectedItem.editing && XEditorItemTypeText == instance.selectedItem.type) {
                //return;
            }

            if(instance.selectedItem.editing) {

                // 이미지 이동
                var contentLeft = parseInt(instance.selectedItem.cell.find(".xe_content").css("left"));
                var contentTop = parseInt(instance.selectedItem.cell.find(".xe_content").css("top"));
                var contentWidth = instance.selectedItem.cell.find(".xe_content").width();
                var contentHeight = instance.selectedItem.cell.find(".xe_content").height();
                var containerWidth = instance.selectedItem.cell.find(".content_container").width();
                var containerHeight = instance.selectedItem.cell.find(".content_container").height();
                var contentNewLeft = contentLeft + distanceX;
                var contentNewTop = contentTop + distanceY;

                if(contentNewLeft > 0 ) {
                    contentNewLeft = 0;
                }

                if(contentNewTop > 0) {
                    contentNewTop = 0;
                }

                if(contentNewLeft + contentWidth < containerWidth) {
                    contentNewLeft = containerWidth - contentWidth;
                }

                if(contentNewTop + contentHeight < containerHeight) {
                    contentNewTop = containerHeight - contentHeight;
                }

                instance.selectedItem.cell.find(".xe_content").css("left", contentNewLeft + "px");
                instance.selectedItem.cell.find(".xe_content").css("top", contentNewTop + "px");


                // offset구하기
                var scale = 0;

                var frameScale = containerWidth / containerHeight;
                var mediaScale = instance.selectedItem.mediaWidth / instance.selectedItem.mediaHeight;

                if(frameScale > mediaScale) {
                    scale = containerWidth / instance.selectedItem.mediaWidth;
                } else {
                    scale = containerHeight / instance.selectedItem.mediaHeight;
                }

                instance.selectedItem.offsetX = (-(contentNewLeft) + (containerWidth / 2)) / instance.selectedItem.scale / scale / instance.selectedItem.mediaWidth;
                instance.selectedItem.offsetY = (-(contentNewTop) + (containerHeight / 2)) / instance.selectedItem.scale / scale / instance.selectedItem.mediaHeight;

                // 클립 영역 처리
                instance.selectedItem.repositionClipRect();

            } else {
                var needsLayout = false;

                if(HIT_TEST_RIGHT_CENTER == instance.selectedItem.hitTestResult || HIT_TEST_RIGHT_BOTTOM == instance.selectedItem.hitTestResult) {

                    instance.selectedItem.cell.width(instance.selectedItem.cell.width() + distanceX);
                    instance.layoutCell(instance.selectedItem);
                }

                if(HIT_TEST_CENTER_BOTTOM == instance.selectedItem.hitTestResult || HIT_TEST_RIGHT_BOTTOM == instance.selectedItem.hitTestResult) {

                    instance.selectedItem.cell.height(instance.selectedItem.cell.height() + distanceY);
                    instance.layoutCell(instance.selectedItem);

                }

                if(HIT_TEST_CENTER == instance.selectedItem.hitTestResult) {
                    instance.selectedItem.cell.css("left", (currentLeft + distanceX) + "px");
                    instance.selectedItem.cell.css("top", (currentTop + distanceY) + "px");
                }

                if(!instance.animating && instance.selectedItem.complete) {

                    if(HIT_TEST_RIGHT_CENTER == instance.selectedItem.hitTestResult || HIT_TEST_RIGHT_BOTTOM == instance.selectedItem.hitTestResult) {

                        if(instance.container.width() < instance.selectedItem.cell.width()) {
                            instance.selectedItem.column = FILL_VIEW;
                            needsLayout = true;
                        } else {
                            for (var i = (instance.columns * 2) - 1; i >= 1; i--) {

                                var widthPX = (i * instance.minBlockWidth) + (i * instance.horizontalSpacing);
                                if(instance.selectedItem.cell.width() > widthPX) {

                                    var newColumn = ((i + 1) / 2.0);
                                    if(newColumn < 1) {
                                        newColumn = 1;
                                    }

                                    if(newColumn > instance.columns) {
                                        newColumn = instance.columns;
                                    }

                                    if(newColumn !=  instance.selectedItem.column) {
                                        instance.selectedItem.column = newColumn;
                                        needsLayout = true;
                                    }

                                    break;
                                }
                            }
                        }
                    }

                    if(HIT_TEST_CENTER_BOTTOM == instance.selectedItem.hitTestResult || HIT_TEST_RIGHT_BOTTOM == instance.selectedItem.hitTestResult) {

                        for(var i = 2; ; i++) {

                            var height = (i * instance.minBlockWidth) + (i * instance.verticalSpacing);
                            if(instance.selectedItem.cell.height() < height) {

                                var newRow = (i / 2.0);
                                if(newRow < 1) {
                                    newRow = 1.0;
                                }

                                if(newRow != instance.selectedItem.cell && CUSTOM_HEIGHT != instance.selectedItem.row) {
                                    instance.selectedItem.row = newRow;
                                    needsLayout = true;
                                }

                                break;
                            }
                        }

                    }

                    if(HIT_TEST_CENTER == instance.selectedItem.hitTestResult) {

                        if(instance.swapItem() && !instance.swapping) {

                            instance.swapping = true;
                            needsLayout = true;
                        }
                    }

                    if(needsLayout) {

                        instance.animating = true;
                        instance.measure();

                        // 플레이스 홀더 애니메이션
                        instance.animatePlaceholderToFrame(instance.selectedItem);

                        for(var i = 0 ; i < instance.items.length ; i++) {

                            var item = instance.items[i];

                            if(item.itemId != instance.selectedItem.itemId) {
                                instance.animatePlaceholderToFrame(item);
                                instance.animateItemToFrame(item);
                            }
                        }

                        setTimeout(function() {
                            instance.swapping = false;
                            instance.animating = false;
                        }, 300);
                    }
                }
            }

        }
    }).on("mouseup", function(e) {

        instance.clickProcess = false;

        if(instance.selectedItem) {

            if(!instance.selectedItem.editing) {
                instance.animateItemToFrame(instance.selectedItem);
            }

            instance.selectedItem.hitTestResult = HIT_TEST_NONE;

            if(!instance.contextMenu && !instance.selectedItem.editing) {
                setTimeout(function() {
                    instance.showContextMenu(instance.selectedItem);
                }, 300);
            }
        }
    });
};

XEditor.prototype.measure = function() {

    this.minBlockWidth = (parseInt(this.container.width())- (this.horizontalSpacing * ((this.columns * 2) - 1))) / (this.columns * 2);
    var columnHeights = new Array();
    for(i = 0 ; i < this.columns * 2 ; i++) {
        columnHeights[i] = this.verticalSpacing;
    }

    var position = 0;

    for(i = 0 ; i < this.items.length ; i++) {

        var item = this.items[i];

        if(FILL_VIEW == item.column || FILL_COLUMN == item.column) {

            // 화면 전체너비를 사용하는 경우 (블럭 줄바꿈)
            position = 0 != parseInt(position % (this.columns * 2)) ? parseInt(((position / (this.columns * 2)) + 1)) * (this.columns * 2) : position;

            item.position = position;

            // 화면상의 좌표 구하기
            var maxY = 0;
            for(var y = 0 ; y < this.columns * 2; y++) {

                maxY = Math.max(maxY, columnHeights[y]);
            }

            var left = 0;
            var top = maxY + this.verticalSpacing;
            var right = this.container.width();
            var bottom = 0;
            if(CUSTOM_HEIGHT == item.row || FILL_VIEW == item.column) {
                bottom  = top + this.measureItemHeight(item, right - left);
            } else {
                bottom = top + (this.minBlockWidth * item.row * 2) + (this.horizontalSpacing * ((item.row * 2) - 1));
            }

            // 프레임 지정
            item.frame = new Rect(parseInt(left), parseInt(top), parseInt(right), parseInt(bottom));

            // 각 칼럼의 bottom 값 저장
            for(var y = 0 ; y < columnHeights.length ; y++) {
                columnHeights[y] = bottom;
            }

            // 다음 블럭아이디 지정
            position += this.columns * 2;

        } else {
            // 일반적인 경우
            while(true) {

                var rightPositionId = (position + (item.column * 2) - 1);
                if(parseInt(position / (this.columns * 2)) < parseInt(rightPositionId / (this.columns * 2))) {
                    // 줄 바꿈
                    position = parseInt(position / (this.columns * 2)) + 1;
                    position *= (this.columns * 2);

                    continue;
                }

                if(!this.isAvailablePosition(i, position, rightPositionId)) {
                    position++;
                    continue;
                }

                break;
            }

            item.position = position;

            // 화면상의 좌표 구하기
            var maxY = 0;
            for(y = position % (this.columns * 2) ;
                y < position % (this.columns * 2) + (item.column * 2); y++) {

                maxY = Math.max(maxY, columnHeights[y]);
            }

            var left = 0 == parseInt(position % (this.columns * 2)) ? 0 :
            ((position % (this.columns * 2)) * this.minBlockWidth) + ((position % (this.columns * 2)) * this.horizontalSpacing);
            var top = maxY + this.verticalSpacing;
            var right = left + (this.minBlockWidth * item.column * 2) + (this.horizontalSpacing * ((item.column * 2) - 1));
            var bottom =  0;

            if(CUSTOM_HEIGHT == item.row) {
                bottom  = top + this.measureItemHeight(item, right - left);
            } else {
                bottom = top + (this.minBlockWidth * item.row * 2) + (this.horizontalSpacing * ((item.row * 2) - 1));
            }

            // 프레임 지정
            item.frame = new Rect(parseInt(left), parseInt(top), parseInt(right), parseInt(bottom));

            // 각 칼럼의 bottom 값 저장
            for(y = position % (this.columns * 2) ;
                y < position % (this.columns * 2) + (item.column * 2); y++) {
                columnHeights[y] = bottom;
            }

            // 다음 블럭아이디 지정
            position += item.column * 2;
        }

    }

    var height = 0;
    for(var i = 0 ; i < columnHeights.length ; i++) {
        height = Math.max(height, columnHeights[i]);
    }

    this.container.height(height + this.verticalSpacing);
}

XEditor.prototype.isAvailablePosition = function(index, leftPosition, rightPosition) {

    var minIndex = index - this.items.length;
    minIndex = minIndex >= 0 ? minIndex : 0;

    for(var i = index - 1; i >= minIndex; i--) {

        var item = this.items[i];

        var column = item.column;
        column =  (FILL_VIEW == column || FILL_COLUMN == column) ? (this.columns * 2) : (column * 2);

        var row = item.row;
        row = CUSTOM_HEIGHT == row ? 1 : row * 2;

        for(var y = leftPosition; y < rightPosition; y++) {

            for(var x = 0; x < column; x++) {

                for(var z = parseInt(row - 1); z >= 0; z--) {

                    var currentPosition = (item.position + x) + (z * (this.columns * 2));
                    if(currentPosition == y) {
                        return false;
                    }
                }
            }
        }
    }

    return true;
}

XEditor.prototype.layout = function() {

    var instance = this;

    for(var i = 0; i < this.items.length; i++) {

        var item = this.items[i];

        if(!item.placeholder) {
            // 플레이스 홀더 생성
            item.placeholder = this.createPlaceholder(item);
            this.container.append(item.placeholder);

        }
        // 플레이스 홀더 위치 설정
        item.placeholder.css("left", (item.frame.left + 10) + "px");
        item.placeholder.css("top", (item.frame.top + 10) + "px");
        item.placeholder.width(item.frame.width() - 20);
        item.placeholder.height(item.frame.height()- 20);

        if(!item.cell) {
            // 셀 생성
            item.cell = this.createCell(item);
            this.container.append(item.cell);

            if(XEditorItemTypeText == item.type || XEditorItemTypeLink == item.type) {

                item.cell.find(".xe_content").on("input",function (e) {

                    item.text = item.cell.find(".text").val();
                    instance.measure();
                    instance.layout();
                });

                item.cell.on("dblclick", function () {

                    if(instance.editing) {
                        if(instance.selectedItem) {
                            instance.selectedItem.setSelected(false);
                            instance.selectedItem.setEditing(false);
                        }

                        instance.hideContextMenu();
                        instance.selectedItem = item;
                        instance.selectedItem.setSelected(true);
                        instance.selectedItem.setEditing(true);
                    }

                });

            } else if(XEditorItemTypeImage == item.type) {

                item.cell.find(".xe_content").load(function() {
                    item.cell.find(".loading").removeClass("loading");
                });

                item.cell.find("[name='incZoom']").click(function() {
                    item.scale += 0.1;
                    if(item.scale > 4) {
                        item.scale = 4;
                    }
                    instance.measure();
                    instance.layout();

                    // 클립 영역 처리
                    instance.selectedItem.repositionClipRect();
                });

                item.cell.find("[name='decZoom']").click(function() {
                    item.scale -= 0.1;
                    if(item.scale < 1) {
                        item.scale = 1;
                    }

                    instance.measure();
                    instance.layout();

                    // 클립 영역 처리
                    instance.selectedItem.repositionClipRect();
                });

            } else if(XEditorItemTypeVideo == item.type) {

                item.cell.find(".xe_content").on("loadeddata", function() {

                    $(this).removeClass("hidden");
                    $(this).css("opacity", "0");
                    $(this).animate({
                        opacity: 1,
                    }, 1000, function() {
                    });

                    item.cell.find(".loading").removeClass("loading");
                });
            } else if(XEditorItemTypeYoutube == item.type) {

                item.cell.find(".xe_content").load(function() {

                    var width = $(this)[0].scrollWidth;
                    var height = $(this)[0].scrollHeight;
                    $(this).removeClass("hidden");
                    $(this).css("opacity", "0");
                    $(this).animate({
                        opacity: 1,
                    }, 1000, function() {
                    });

                    item.cell.find(".loading").removeClass("loading");
                    if(!instance.editing) {
                        item.cell.find(".fill").hide();
                    }
                });
            }
        }

        // 셀 위치 설정
        item.cell.css("left", item.frame.left + "px");
        item.cell.css("top", item.frame.top + "px");
        item.cell.width(item.frame.width());
        item.cell.height(item.frame.height());

        // 셀 컨텐츠 조정
        this.layoutCell(item);

        if(!this.editing) {
            this.container.find(".unselectable").removeClass("unselectable");
        }
    }
}

XEditor.prototype.createPlaceholder = function(item) {

    var placeholder = $("<div>");
    placeholder.addClass("placeholder");
    placeholder.addClass("z_low");

    return placeholder;
}

XEditor.prototype.createCell = function(item) {

    if(XEditorItemTypeText == item.type) {

        var html = "<div class='cell unselectable z_normal' data-id=" + item.itemId + ">";
        html += "<div class='content_container'>";
        html += "<div class='fill bg_white'/>";
        html += "<div class='border hidden'/>";
        html += "<textarea class='xe_content content_text text' autocorrect='off' placeholder='내용을 입력하세요' disabled></textarea>";
        html += "</div>";
        if(item.resizeable) {
            html += "<div class='resize_container hidden'><div class='resize'></div></div>";
        }

        html += "</div>";

        html = $(html);
        html.find(".text").addClass("text");
        html.find(".text").css("color", item.textColor);
        html.find(".text").css("font-size", item.textSize + "px");

        if(XEditorItemTextStyleNormal == item.textStyle) {
            html.find(".text").addClass("text_normal");
        } else if(XEditorItemTextStyleHeader == item.textStyle) {
            html.find(".text").addClass("text_header");
        }  else if(XEditorItemTextStyleQuote == item.textStyle) {
            html.find(".text").addClass("text_quote");
        }

        if(XEditorItemTextAlignLeft == item.textAlign) {
            html.find(".text").addClass("text_left");
        } else if(XEditorItemTextAlignCenter == item.textAlign) {
            html.find(".text").addClass("text_center");
        }  else if(XEditorItemTextAlignRight == item.textAlign) {
            html.find(".text").addClass("text_right");
        }
        html.find("textarea").val(item.text);

        return html;

    } else if(XEditorItemTypeImage == item.type) {

        var html = "<div class='cell unselectable z_normal' data-id=" + item.itemId + ">";
        html += "<div class='content_container crop'>";
        html += "<img name='content' class='xe_content bg_gray' src='" + (item.complete ? item.contentUrl : "") + "'/>";
        html += "<div class='border hidden'></div>";
        html += "</div>";

        if(item.resizeable) {
            html += "<div class='resize_container hidden'><div class='resize'></div></div>";
        }

        html += "<div class='fill loading'></div>";
        html += "<div class='button_zoomin' style='display:none' name='incZoom'/>"
        html += "<div class='button_zoomout' style='display:none' name='decZoom'/>"
        html += "</div>";


        return $(html);

    } else if(XEditorItemTypeVideo == item.type) {

        var html = "<div class='cell unselectable z_normal' data-id=" + item.itemId + ">";
        html += "<div class='content_container crop'>";
        html += "<video autoplay loop class='xe_content hidden'>";
        html += "<source src='" + (item.complete ? item.contentUrl : "") + "' type='video/mp4'>";
        html += "</video>"
        html += "<div class='border hidden'></div>";
        html += "</div>";

        if(item.resizeable) {
            html += "<div class='resize_container hidden'><div class='resize'></div></div>";
        }

        html += "<div class='fill loading'></div>";

        html += "</div>";


        return $(html);

    } else if(XEditorItemTypeYoutube == item.type) {

        var html = "<div class='cell unselectable z_normal' data-id=" + item.itemId + ">";
        html += "<div class='content_container crop'>";
        html += "<iframe class='xe_content bg_gray' allowfullscreen='' frameborder='0' src='https://www.youtube.com/embed/" + item.contentUrl + "'></iframe>"
        html += "<div class='border hidden'></div>";
        html += "</div>";

        if(item.resizeable) {
            html += "<div class='resize_container hidden'><div class='resize'></div></div>";
        }

        html += "<div class='fill loading'></div>";

        html += "</div>";


        return $(html);

    } if(XEditorItemTypeLink == item.type) {

        var html = "<div class='cell unselectable z_normal' data-id=" + item.itemId + ">";
        html += "<div class='content_container'>";
        html += "<div class='fill bg_white'/>";
        html += "<div class='border hidden'/>";
        if(this.editing) {
            html += "<textarea class='xe_content content_text text' autocorrect='off' placeholder='내용을 입력하세요' disabled></textarea>";
        } else {
            html += "<a style='display:block' target='_blank' href='" + item.contentUrl + "' class='xe_content content_text text'><div>" + (item.text ? item.text : item.contentUrl) + "</div></a>";
        }

        html += "</div>";
        if(item.resizeable) {
            html += "<div class='resize_container hidden'><div class='resize'></div></div>";
        }

        html += "</div>";

        html = $(html);
        html.find(".text").addClass("text");
        html.find(".text").css("color", item.textColor);
        html.find(".text").css("font-size", item.textSize + "px");

        if(XEditorItemTextStyleNormal == item.textStyle) {
            html.find(".text").addClass("text_normal");
        } else if(XEditorItemTextStyleHeader == item.textStyle) {
            html.find(".text").addClass("text_header");
        }  else if(XEditorItemTextStyleQuote == item.textStyle) {
            html.find(".text").addClass("text_quote");
        }

        if(XEditorItemTextAlignLeft == item.textAlign) {
            html.find(".text").addClass("text_left");
        } else if(XEditorItemTextAlignCenter == item.textAlign) {
            html.find(".text").addClass("text_center");
        }  else if(XEditorItemTextAlignRight == item.textAlign) {
            html.find(".text").addClass("text_right");
        }
        html.find("textarea").val(item.text);

        return html;

    }
}

XEditor.prototype.layoutCell = function(item) {

    if(XEditorItemTypeText == item.type) {

        //item.cell.find(".xe_content").children().remove();
        //
        //if(item.text && item.text.length) {
        //    var strings = item.text.replace(/(?:\r\n|\r|\n)/g, "\n").split("\n");
        //    var content = "";
        //    for(var i = 0 ; i < strings.length ; i++) {
        //        if(strings[i].length) {
        //            xe_content += "<p class='text'>" + strings[i] + "</p>";
        //        } else {
        //            xe_content += "<p class='text'><br/></p>";
        //        }
        //    }
        //    item.cell.find(".xe_content").append($(content));
        //
        //    if(XEditorItemTextStyleNormal == item.textStyle) {
        //        item.cell.find(".text").addClass("text_normal");
        //    } else if(XEditorItemTextStyleHeader == item.textStyle) {
        //        item.cell.find(".text").addClass("text_header");
        //    }  else if(XEditorItemTextStyleQuote == item.textStyle) {
        //        item.cell.find(".text").addClass("text_quote");
        //    }
        //
        //    if(XEditorItemTextAlignLeft == item.textAlign) {
        //        item.cell.find(".text").addClass("text_left");
        //    } else if(XEditorItemTextAlignCenter == item.textAlign) {
        //        item.cell.find(".text").addClass("text_center");
        //    }  else if(XEditorItemTextAlignRight == item.textAlign) {
        //        item.cell.find(".text").addClass("text_right");
        //    }
        //} else {
        //    item.cell.find(".xe_content").append("<p class='text'></p>");
        //    //html += "<p class='text'></p>";
        //}

    } else if(XEditorItemTypeVideo == item.type || XEditorItemTypeImage == item.type) {

        if(!item.complete) {

            var content = item.cell.find(".xe_content");

            content.css("left", left + "px");
            content.css("top", top + "px");
            content.width("100%");
            content.height("100%");

        } else {
            var contentContainer = item.cell.find(".content_container");
            var contentFrame = new Rect(0, 0, contentContainer.innerWidth(), contentContainer.innerHeight());

            var scale = 0;
            var left = 0;
            var top = 0;
            var displayWidth = 0;
            var displayHeight = 0;
            var frameScale = contentFrame.width() / contentFrame.height();
            var mediaScale = item.mediaWidth / item.mediaHeight;

            if(frameScale > mediaScale) {
                displayWidth = contentFrame.width();
                scale = displayWidth / item.mediaWidth;
                displayHeight = item.mediaHeight * scale;
            } else {
                displayHeight = contentFrame.height();
                scale = displayHeight / item.mediaHeight;
                displayWidth = item.mediaWidth * scale;
            }

            var contentOffsetX = (item.offsetX * item.mediaWidth * scale * item.scale) - (contentFrame.width() / 2);
            var contentOffsetY = (item.offsetY * item.mediaHeight * scale * item.scale) - (contentFrame.height() / 2);
            displayWidth *= item.scale;
            displayHeight *= item.scale;

            left =  contentOffsetX * -1;
            top = contentOffsetY * -1;

            if(left + displayWidth < contentFrame.width()) {
                left = contentFrame.width() - displayWidth;
            }

            if(0 < left) {
                left = 0;
            }

            if(top + displayHeight < contentFrame.height()) {
                top = contentFrame.height() - displayHeight;
            }

            if(0 < top) {
                top = 0;
            }

            var content = item.cell.find(".xe_content");

            content.css("left", left + "px");
            content.css("top", top + "px");
            content.width(displayWidth);
            content.height(displayHeight);
        }
    } else if(XEditorItemTypeYoutube == item.type) {

        var contentContainer = item.cell.find(".content_container");
        var contentFrame = new Rect(0, 0, contentContainer.innerWidth(), contentContainer.innerHeight());

        var content = item.cell.find(".xe_content");
        content.css("left", "0px");
        content.css("top", "0px");
        content.width(contentFrame.width());
        content.height(contentFrame.height());
    }
}


XEditor.prototype.itemForCell = function(cell) {

    for(var i = 0 ; i < this.items.length ; i++) {
        var item = this.items[i];
        if(item.itemId == $(cell).attr("data-id")) {
            return item;
        }
    }

    return null;
}

XEditor.prototype.animateItemToFrame = function(item) {

    if(parseInt(item.cell.css("left")) != parseInt(item.frame.left) ||
        parseInt(item.cell.css("top")) != parseInt(item.frame.top) ||
        parseInt(item.cell.css("width")) != parseInt(item.frame.width()) ||
        parseInt(item.cell.css("height")) != parseInt(item.frame.height()) ) {

        item.cell.animate({

            left: item.frame.left,
            top: item.frame.top,
            width: item.frame.width(),
            height: item.frame.height(),

        }, 250, function() {
        });
    }


    // 컨텐츠 애니메이션
    if(XEditorItemTypeVideo == item.type || XEditorItemTypeImage == item.type) {

        var contentContainer = item.cell.find(".content_container");
        var contentFrame = new Rect(0, 0, item.frame.width() - 20, item.frame.height() - 20);

        var left = 0;
        var top = 0;
        var displayWidth = 0;
        var displayHeight = 0;
        var frameScale = contentFrame.width() / contentFrame.height();
        var mediaScale = item.mediaWidth / item.mediaHeight;

        if(frameScale > mediaScale) {
            displayWidth = contentFrame.width();
            var scale = displayWidth / item.mediaWidth;
            displayHeight = item.mediaHeight * scale;
        } else {
            displayHeight = contentFrame.height();
            var scale = displayHeight / item.mediaHeight;
            displayWidth = item.mediaWidth * scale;
        }

        var contentOffsetX = (item.offsetX * item.mediaWidth * scale * item.scale) - (contentFrame.width() / 2);
        var contentOffsetY = (item.offsetY * item.mediaHeight * scale * item.scale) - (contentFrame.height() / 2);
        displayWidth *= item.scale;
        displayHeight *= item.scale;

        //left =  -(displayWidth - contentFrame.width()) / 2;
        //top = -(displayHeight - contentFrame.height()) / 2;
        left =  contentOffsetX * -1;
        top = contentOffsetY * -1;


        if(left + displayWidth < contentFrame.width()) {
            left = contentFrame.width() - displayWidth;
        }

        if(0 < left) {
            left = 0;
        }

        if(top + displayHeight < contentFrame.height()) {
            top = contentFrame.height() - displayHeight;
        }

        if(0 < top) {
            top = 0;
        }

        var content = item.cell.find(".xe_content");

        content.animate({

            left: left,
            top: top,
            width: displayWidth,
            height: displayHeight,

        }, 250, function() {
        });

    } else if(XEditorItemTypeYoutube == item.type) {

        var contentContainer = item.cell.find(".content_container");
        var contentFrame = new Rect(0, 0, contentContainer.innerWidth(), contentContainer.innerHeight());

        var content = item.cell.find(".xe_content");
        //content.css("left", "0px");
        //content.css("top", "0px");
        //content.width(contentFrame.width());
        //content.height(contentFrame.height());

        content.animate({

            left: "0",
            top: "0",
            width: item.frame.width() - 20,
            height: item.frame.height() - 20,

        }, 250, function() {
        });
    }

}

XEditor.prototype.animatePlaceholderToFrame = function(item) {

    item.placeholder.animate({

        left: item.frame.left + 10,
        top: item.frame.top + 10,
        width: item.frame.width() - 20,
        height: item.frame.height() - 20,

    }, 250, function() {
    });
}

XEditor.prototype.swapItem = function() {

    var maxDestBlockIndex = -1;
    var minDestBlockIndex = 1000000;
    var selectedItemIndex = 0;

    // 현재 선택된 셀의 인덱스 구하기
    for(var i = 0 ; i < this.items.length; i++)  {
        if(this.selectedItem.itemId == this.items[i].itemId) {
            selectedItemIndex = i;
            break;
        }
    }

    var left = parseInt($(this.selectedItem.cell).css("left"));
    var top = parseInt($(this.selectedItem.cell).css("top"));
    var right = left + this.selectedItem.cell.width();
    var bottom = top + this.selectedItem.cell.height();

    var selectedBlockFrame = new Rect(left, top,right, bottom);

    // 자리를 바꿀 셀의 인덱스 구하기
    for(var i = 0 ; i < this.items.length; i++)  {

        var item = this.items[i];

        if(item != this.selectedItem)  {

            if(this.swappable(selectedBlockFrame, item.frame)) {
                maxDestBlockIndex = Math.max(maxDestBlockIndex, i);
                minDestBlockIndex = Math.min(minDestBlockIndex, i);
            }
        }
    }

    // 자리 바꾸기
    if(-1 < maxDestBlockIndex || 1000000 > minDestBlockIndex) {

        if(selectedItemIndex < maxDestBlockIndex)  {

            this.items.splice(maxDestBlockIndex + 1, 0, this.items[selectedItemIndex]);
            this.items.splice(selectedItemIndex, 1);
            return true;

        }  else  {
            this.items.splice(minDestBlockIndex, 0, this.items[selectedItemIndex]);
            this.items.splice(selectedItemIndex + 1, 1);
            return true;
        }

    }

    return false;
}

XEditor.prototype.swappable = function(frame1, frame2) {


    if(frame1.intersectRect(frame2)) {

        var width =
            Math.max(0, Math.min(frame1.right, frame2.right) - Math.max(frame1.left, frame2.left));

        var height =
            Math.min(frame1.bottom, frame2.bottom) - Math.max(0, Math.max(frame1.top, frame2.top));

        return width > 30 && height > 30;
    }

    return false;
}


XEditor.prototype.measureItemHeight = function(item, containerWidth) {

    var height = 0;
    if(XEditorItemTypeText == item.type) {

        // 텍스트 아이템일 경우
        var cell = this.createCell(item);

        cell.css("left", "0px");
        cell.css("top", "0px");
        cell.width(containerWidth);
        this.container.append(cell);
        height = cell.find(".text")[0].scrollHeight;
        cell.remove();
        return height == 0 ? this.minBlockWidth : height + 20;

    } else if(XEditorItemTypeImage == item.type || XEditorItemTypeVideo == item.type) {

        if(FILL_VIEW == item.column || CUSTOM_HEIGHT == item.row) {
            var scale = this.container.width() / item.mediaWidth;
            var height = item.mediaHeight * scale;
            return height;
        }
    } else if(XEditorItemTypeLink == item.type) {

        if(this.editing) {
            // 텍스트 아이템일 경우
            var cell = this.createCell(item);

            cell.css("left", "0px");
            cell.css("top", "0px");
            cell.width(containerWidth);
            this.container.append(cell);
            height = cell.find(".text")[0].scrollHeight;
            cell.remove();
            return height == 0 ? this.minBlockWidth : height + 20;

        } else {
            // 텍스트 아이템일 경우
            var cell = this.createCell(item);

            cell.css("left", "0px");
            cell.css("top", "0px");
            cell.width(containerWidth);
            this.container.append(cell);
            height = cell.find(".text").children().height();
            cell.remove();
            return height == 0 ? this.minBlockWidth : height + 20;
        }
    }

    return 0;

}

XEditor.prototype.showContextMenu = function(item, type) {

    this.hideContextMenu();

    this.contextMenu = this.createContextMenu(item, type);
    this.container.append(this.contextMenu);
    this.contextMenu.css("left", (item.frame.width() / 2) + item.frame.left - (this.contextMenu.width() / 2));
    this.contextMenu.css("top", this.selectedItem.frame.top - this.contextMenu.height() + 5);
    this.contextMenu.hide();
    this.contextMenu.fadeIn(250);

}

XEditor.prototype.hideContextMenu = function() {

    if(this.contextMenu) {
        var contextMenu = this.contextMenu;
        this.contextMenu = null;
        contextMenu.fadeOut(250, function() {
            contextMenu.remove();
        });
    }
}

XEditor.prototype.createContextMenu = function(item, type) {

    if(type) {

        if(ContextMenuTypeTextStyle == type) {

            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button id="ico_text_style_normal" class="btn_icon ico_style_normal">normal</button></li>';
            html += '<li><button id="ico_text_style_header" class="btn_icon ico_style_header">header</button></li>';
            html += '<li><button id="ico_text_style_quote" class="btn_icon ico_style_quote">quote</button></li>';
            html += '<li><button id="ico_menu_cancel" class="btn_icon ico_cancel"></button></li>';
            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);

        } else if(ContextMenuTypeTextAlign == type) {

            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button id="ico_text_align_left" class="btn_icon ico_align_left">left</button></li>';
            html += '<li><button id="ico_text_align_center" class="btn_icon ico_align_center">center</button></li>';
            html += '<li><button id="ico_text_align_right" class="btn_icon ico_align_right">right</button></li>';
            html += '<li><button id="ico_menu_cancel" class="btn_icon ico_cancel"></button></li>';
            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);

        } else if(ContextMenuTypeTextSize == type) {

            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button id="ico_text_size_up" class="btn_icon ico_size_up">center</button></li>';
            html += '<li><div id="text-size">' + item.textSize + 'px</div></li>';
            html += '<li><button id="ico_text_size_down" class="btn_icon ico_size_down">left</button></li>';
            html += '<li><button id="ico_menu_cancel" class="btn_icon ico_cancel"></button></li>';
            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);

        } else if(ContextMenuTypeTextColor == type) {

            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_1"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_2"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_3"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_4"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_5"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_6"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_7"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_8"></button></li>';
            html += '<li><button data-id="ico_text_color" class="btn_icon ico_color_9"></button></li>';
            html += '<li><button id="ico_menu_cancel" class="btn_icon ico_cancel"></button></li>';

            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);
        }

    } else {

        if(XEditorItemTypeText == item.type || XEditorItemTypeLink == item.type) {

            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button id="ico_editing" class="btn_icon ico_write">write</button></li>';
            html += '<li><button id="ico_style" class="btn_icon ico_style">text style</button></li>';
            html += '<li><button id="ico_size" class="btn_icon ico_size">text size</button></li>';
            html += '<li><button id="ico_color" class="btn_icon ico_color">text size</button></li>';
            html += '<li><button id="ico_align" class="btn_icon ico_align">text align</button></li>';
            html += '<li><button id="ico_delete" class="btn_icon ico_delete">delete</button></li>';
            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);

        } else if(XEditorItemTypeImage == item.type) {
            // 이미지
            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button id="ico_crop" class="btn_icon ico_crop">crop</button></li>';
            html += '<li><button id="ico_delete" class="btn_icon ico_delete">delete</button></li>';
            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);

        } else {
            // 비디오
            var html = '<div id="editor_btn_icons">';
            html += '<ul>';
            html += '<li><button id="ico_delete" class="btn_icon ico_delete">delete</button></li>';
            html += '</ul>';
            html += '<p class="bottom_arrow"></p>';
            html += '</div>';

            return $(html);
        }
    }
}

XEditor.prototype.indexForItem = function(item) {

    for(var i = 0 ; i < this.items.length ; i++) {
        var temp = this.items[i];
        if(item.itemId == temp.itemId) {
            return i;
        }
    }

    return null;
}

XEditor.prototype.removeItem = function(item) {

    item.cell.remove();
    item.placeholder.remove();
    this.items.splice(this.indexForItem(item), 1);
    this.measure();

    this.selectedItem = null;

    var instance = this;
    for(var i = 0 ; i < this.items.length ; i++) {

        var item = this.items[i];
        instance.animateItemToFrame(item);
        instance.animatePlaceholderToFrame(item);
    }
}