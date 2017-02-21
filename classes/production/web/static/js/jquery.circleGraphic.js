(function($){
	$.fn.circleGraphic=function(options){
		$.fn.circleGraphic.defaults={
			color:'#dd193c',
			startAngle: 0,
			lineWidth: 5
		};

		$(this).each(function () {
			var $target  = $(this);

			var opts = $.extend({},$.fn.circleGraphic.defaults,options);

			var percentage=$target.attr('data-form');
			var ID="c"+percentage+Math.random();
			//alert(ID);

			$target.append("<canvas id='"+ID+"'></canvas>");

			var canvas=document.getElementById(ID),
				context=canvas.getContext('2d');

			var Width = $target.width();
			$target.height(Width);
			var Height = $target.height();

			canvas.width = Width;
			canvas.height = Height;

			var startAngle = opts.startAngle,
				endAngle = percentage/100,
				angle = startAngle,
				radius = Width*0.4;

			draw(context, Width, Height, startAngle, endAngle, radius, angle, opts, percentage);
		});

		function drawTrackArc(context, Width, Height, startAngle, endAngle, radius, angle,_line){
			var lineWidth = _line;
			context.beginPath();
			context.strokeStyle = '#e1e1e1';
			context.lineWidth = lineWidth;
			context.arc(Width/2,Height/2,radius,(Math.PI/180)*(startAngle*360-90),(Math.PI/180)*(endAngle*360+270),false);
			context.stroke();
			context.closePath();
		}

		function drawOuterArc(context, Width, Height, startAngle, endAngle, radius, angle,_angle,_color,_line){
			var angle = _angle;
			var color = _color;
			var lineWidth = _line;
			context.beginPath();
			context.strokeStyle = color;
			context.lineWidth = lineWidth;
			context.arc(Width/2,Height/2,radius,(Math.PI / 180) * (startAngle * 360 - 90), (Math.PI / 180) * (angle * 360 - 90), false);
			context.stroke();
			context.closePath();
		}

		function numOfPercentage(context, Width, Height, startAngle, endAngle, radius, angle,_percentage){
			context.font = Width/4+"px Arial Black";
			context.fillStyle = '#353535';

			if(_percentage.length == 1) {
				var xPos = Width/3.1, yPos = Height/1.72;
			} else if(_percentage.length == 2) {
				var xPos = Width/4, yPos = Height/1.72;
			} else {
				var xPos = Width/5.7, yPos = Height/1.72;
			}
			context.fillText(_percentage+"%",xPos,yPos);
		}

		function draw(context, Width, Height, startAngle, endAngle, radius, angle, opts, percentage){
			var loop = setInterval(function(){
				context.clearRect(0,0,Width,Height);
				drawTrackArc(context, Width, Height, startAngle, endAngle, radius, angle,opts.lineWidth);
				drawOuterArc(context, Width, Height, startAngle, endAngle, radius, angle,angle,opts.color,opts.lineWidth);
				numOfPercentage(context, Width, Height, startAngle, endAngle, radius, angle,percentage);
				angle+=0.01;
				if(angle>endAngle){
					clearInterval(loop);
				}

			},1000/60);

			return;
		}


	};
})(jQuery);