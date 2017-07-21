/ *!
 * jQuery Cycle Plugin (전환 ​​정의 포함)
 * 예제 및 설명서 : http://jquery.malsup.com/cycle/
 * Copyright (c) 2007-2013 M. Alsup
 * 버전 : 3.0.3 (2013 년 11 월 11 일)
 * 듀얼 라이선스는 MIT 및 GPL 라이센스에 의거합니다.
 * http://jquery.malsup.com/license.html
 * 요구 사항 : jQuery v1.7.1 이상
 * /
; (function ($, undefined) {
"엄격한 사용";

var ver = '3.0.3';

함수 디버그 {
	if ($ .fn.cycle.debug)
		로그;
}		
함수 로그 () {
	/ * 글로벌 콘솔 * /
	if (window.console && console.log)
		console.log ( '[cycle]'+ Array.prototype.join.call (arguments, ''));
}
$ .expr [ ':']. 일시 중지됨 = function (el) {
	return el.cyclePause;
};


// 옵션 arg가 될 수있는 ...
// 숫자 - 주어진 슬라이드 인덱스로 즉각적인 전환이 발생해야 함을 나타냅니다.
// '일시 중지', '다시 시작', '토글', '다음', '이전', '중지', '파괴'또는 전환 효과의 이름 (예 : '페이드', '확대 / 축소' 기타)
// 객체 - 슬라이드 쇼를 제어하는 ​​속성
//
// arg2 arg가 될 수 있습니다 ...
// fx의 이름 ( 'options'에 대한 숫자 값과 함께 사용됨)
// true 값 (첫 번째 arg == 'resume'에서만 사용됨)을 나타내며
// 이력서가 즉시 발생해야 함 (다음 시간 초과을 기다리지 않음)

$ .fn.cycle = function (options, arg2) {
	var o = {s : this.selector, c : this.context};

	// 1.3 이상에서는 준비 상태로 실수를 수정할 수 있습니다.
	if (this.length === 0 && options! = 'stop') {
		if (! $. isReady && os) {
			로그 ( 'DOM 준비되지 않음, 대기 슬라이드 쇼');
			$ (function () {
				$ (os, oc) .cycle (options, arg2);
			});
			이것을 돌려 보내라.
		}
		// 당신의 DOM은 준비 되었습니까? http://docs.jquery.com/Tutorials:Introducing_$ (document) .ready ()
		log ( '종결, 선택자에 의해 발견 된 0 개의 요소 + ($ .isReady?' ':'(DOM 준비 안 됨) ')));
		이것을 돌려 보내라.
	}

	// 일치하는 노드 집합을 반복합니다.
	return this.each (function () {
		var opts = handleArguments (this, options, arg2);
		if (opts === false)
			반환;

		opts.updateActivePagerLink = opts.updateActivePagerLink || $ .fn.cycle.updateActivePagerLink;
		
		//이 컨테이너에 대한 기존 슬라이드 쇼를 중지합니다 (있는 경우).
		if (this.cycleTimeout)
			clearTimeout (this.cycleTimeout);
		this.cycleTimeout = this.cyclePause = 0;
		this.cycleStop = 0; // 문제 # 108

		var $ cont = $ (this);
		var $ slides = opts.slideExpr? $ (opts.slideExpr, this) : $ cont.children ();
		var els = $ slides.get ();

		if (els.length <2) {
			로그 ( '종료, 너무 적은 슬라이드 :'+ els.length);
			반환;
		}

		var opts2 = buildOptions ($ cont, $ slides, els, opts, o);
		if (opts2 === false)
			반환;

		var startTime = opts2.continuous? 10 : getTimeout (els [opts2.currSlide], els [opts2.nextSlide], opts2,! opts2.backwards);

		// 자동 슬라이드 쇼인 경우 킥 오프하십시오.
		if (startTime) {
			startTime + = (opts2.delay || 0);
			if (startTime <10)
				startTime = 10;
			디버그 ( 'first timeout :'+ startTime);
			this.cycleTimeout = setTimeout (function () {go (els, opts2,0,! opts.backwards);}, startTime);
		}
	});
};

함수 triggerPause (cont, byHover, onPager) {
	var opts = $ (계속) .data ( 'cycle.opts');
	if (! opts)
		반환;
	var paused = !! cont.cyclePause;
	if (일시 중지됨 && opts.paused)
		opts.paused (cont, opts, byHover, onPager);
	else if (! paused && opts.resumed)
		opts.resumed (cont, opts, byHover, onPager);
}

// 플러그인 fn에 전달 된 args를 처리합니다.
함수 handleArguments (cont, options, arg2) {
	if (cont.cycleStop === undefined)
		cont.cycleStop = 0;
	if (options === undefined || options === null)
		옵션 = {};
	if (options.constructor == String) {
		스위치 (옵션) {
		'파괴하다':
		case 'stop':
			var opts = $ (계속) .data ( 'cycle.opts');
			if (! opts)
				false를 반환;
			cont.cycleStop ++; // 콜백은 변경을 찾습니다.
			if (cont.cycleTimeout)
				clearTimeout (cont.cycleTimeout);
			cont.cycleTimeout = 0;
			if (opts.elements)
				$ (opts.elements) .stop ();
			$ (계속) .removeData ( 'cycle.opts');
			if (options == 'destroy')
				파괴하다 (계속하다, 선택하다);
			false를 반환;
		case '토글':
			cont.cyclePause = (cont.cyclePause === 1)? 0 : 1;
			checkInstantResume (cont.cyclePause, arg2, cont);
			triggerPause (계속);
			false를 반환;
		'일시 중지':
			cont.cyclePause = 1;
			triggerPause (계속);
			false를 반환;
		사례 '재개':
			cont.cyclePause = 0;
			checkInstantResume (false, arg2, cont);
			triggerPause (계속);
			false를 반환;
		'prev'의 경우
		'다음'사례 :
			opts = $ (계속). 데이터 ( 'cycle.opts');
			if (! opts) {
				log ( '옵션을 찾을 수 없습니다', 이전 / 다음 '무시');
				false를 반환;
			}
			if (typeof arg2 == 'string') 
				opts.oneTimeFx = arg2;
			$ .fn.cycle [options] (opts);
			false를 반환;
		태만:
			options = {fx : options};
		}
		반환 옵션;
	}
	else if (options.constructor == Number) {
		// 요청한 슬라이드로 이동
		var num = options;
		옵션 = $ (계속). 데이터 ( 'cycle.opts');
		if (! options) {
			로그 ( '옵션을 찾을 수 없으며 슬라이드를 넘길 수 없습니다');
			false를 반환;
		}
		if (num <0 || num> = options.elements.length) {
			로그 ( 'invalid slide index :'+ num);
			false를 반환;
		}
		options.nextSlide = num;
		if (cont.cycleTimeout) {
			clearTimeout (cont.cycleTimeout);
			cont.cycleTimeout = 0;
		}
		if (typeof arg2 == 'string')
			options.oneTimeFx = arg2;
		go (options.elements, options, 1, num> = options.currSlide);
		false를 반환;
	}
	반환 옵션;
	
	function checkInstantResume (isPaused, arg2, cont) {
		if (! isPaused && arg2 === true) {// 이제 다시 시작하십시오!
			var options = $ (계속) .data ( 'cycle.opts');
			if (! options) {
				log ( '옵션을 찾을 수 없으며 다시 시작할 수 없습니다');
				false를 반환;
			}
			if (cont.cycleTimeout) {
				clearTimeout (cont.cycleTimeout);
				cont.cycleTimeout = 0;
			}
			go (options.elements, options, 1,! options.backwards);
		}
	}
}

함수 removeFilter (el, opts) {
	if (! $. support.opacity && opts.cleartype && el.style.filter) {
		try {el.style.removeAttribute ( 'filter'); }
		catch (smother) {} // 오래된 오페라 버전 처리
	}
}

// 이벤트 핸들러 바인딩 해제
함수를 파괴 (cont, opts) {
	if (opts.next)
		$ (opts.next) .unbind (opts.prevNextEvent);
	if (opts.prev)
		$ (opts.prev) .unbind (opts.prevNextEvent);
	
	if (opts.pager || opts.pagerAnchorBuilder)
		$ .each (opts.pagerAnchors || [], function () {
			this.unbind (). remove ();
		});
	opts.pagerAnchors = null;
	$ (계속) .unbind ( 'mouseenter.cycle mouseleave.cycle');
	if (opts.destroy) // 콜백
		opts.destroy (opts);
}

// 한 번 초기화
함수 buildOptions ($ cont, $ slides, els, options, o) {
	var startingSlideSpecified;
	// 메타 데이터 플러그인 지원 (v1.0 및 v2.0)
	var opts = $ .metadata () : $ .meta? $ cont.data () : {}); var opts = $ .extend ({}, $ .fn.cycle.defaults, options ||
	var meta = $ .isFunction ($ cont.data)? $ cont.data (opts.metaAttr) : null;
	(메타)
		opts = $ .extend (opts, meta);
	if (opts.autostop)
		opts.countdown = opts.autostopCount || els.length;

	var cont = $ cont [0];
	$ cont.data ( 'cycle.opts', opts);
	opts. $ cont = $ cont;
	opts.stopCount = cont.cycleStop;
	opts.elements = els;
	opts.before = opts.before? [opts.before] : [];
	opts.after = opts.after? [opts.after] : [];

	// 콜백 후 일부를 푸시합니다.
	if (! $. support.opacity && opts.cleartype)
		opts.after.push (function () {removeFilter (this, opts);});
	if (opts.continuous)
		opts.after.push (function () {go (els, opts, 0,! opts.backwards);});

	saveOriginalOpts (opts);

	// clearType 수정
	if (! $. support.opacity && opts.cleartype &&! opts.cleartypeNoBg)
		clearTypeFix ($ 슬라이드);

	// 컨테이너는 비 정적 인 위치를 필요로하므로 슬라이드가
	if ($ cont.css ( 'position') == '정적')
		$ cont.css ( '위치', '상대');
	if (opts.width)
		$ cont.width (opts.width);
	if (opts.height && opts.height! = 'auto')
		$ cont.height (opts.height);

	if (opts.startingSlide! == undefined) {
		opts.startingSlide = parseInt (opts.startingSlide, 10);
		if (opts.startingSlide> = els.length || opts.startSlide <0)
			opts.startingSlide = 0; // 가짜 입력을 잡아라.
		그밖에 
			startingSlideSpecified = true;
	}
	else if (opts.backwards)
		opts.startingSlide = els.length - 1;
	그밖에
		opts.startingSlide = 0;

	// 무작위 인 경우 슬라이드 배열을 섞습니다.
	if (opts.random) {
		opts.randomMap = [];
		for (var i = 0; i <els.length; i ++)
			opts.randomMap.push (i);
		opts.randomMap.sort (function (a, b) {return Math.random () - 0.5;});
		if (startingSlideSpecified) {
			// 지정된 시작 슬라이드를 찾으려고 시도하고 찾으면지도의 시작 슬라이드 인덱스를 설정합니다.
			for (var cnt = 0; cnt <els.length; cnt ++) {
				if (opts.startingSlide == opts.randomMap [cnt]) {
					opts.randomIndex = cnt;
				}
			}
		}
		else {
			opts.randomIndex = 1;
			opts.startingSlide = opts.randomMap [1];
		}
	}
	else if (opts.startingSlide> = els.length)
		opts.startingSlide = 0; // 가짜 입력을 잡아라.
	opts.currSlide = opts.startingSlide || 0;
	var first = opts.startingSlide;

	// 모든 슬라이드에서 position과 zIndex를 설정합니다.
	$ slides.css ({위치 : '절대', 상단 : 0, 왼쪽 : 0}) hide (). 각 (function (i) {
		var z;
		if (opts.backwards)
			z = 처음? 나는 <= 처음? els.length + (i-first) : first-i : els.length-i;
		그밖에
			z = 처음? 내가 처음? els.length - (i-first) : first-i : els.length-i;
		$ (this) .css ( 'z-index', z);
	});

	// 첫 번째 슬라이드가 표시되는지 확인합니다.
	$ (els [first]) .css ( 'opacity', 1) .show (); // 재시작 사용 사례를 처리하는 데 필요한 불투명 비트
	removeFilter (els [first], opts);

	// 슬라이드 늘이기
	if (opts.fit) {
		if (! opts.aspect) {
	        if (opts.width)
	            $ slides.width (opts.width);
	        if (opts.height && opts.height! = 'auto')
	            $ slides.height (opts.height);
		} else {
			$ slides.each (function () {
				var $ slide = $ (this);
				var ratio = (opts.aspect === true)? $ slide.width () / $ slide.height () : opts.aspect;
				if (opts.width && $ slide.width ()! = opts.width) {
					$ slide.width (opts.width);
					$ slide.height (opts.width / ratio);
				}

				if (opts.height && $ slide.height () <opts.height) {
					$ slide.height (opts.height);
					$ slide.width (opts.height * ratio);
				}
			});
		}
	}

	if (opts.center && ((! opts.fit) || opts.aspect)) {
		$ slides.each (function () {
			var $ slide = $ (this);
			$ slide.css ({
				"margin-left": opts.width?
					((opts.width - $ slide.width ()) / 2) + "px":
					0,
				"margin-top": opts.height?
					((opts.height - $ slide.height ()) / 2) + "px":
					0
			});
		});
	}

	if (opts.center &&! opts.fit &&! opts.slideResize) {
		$ slides.each (function () {
			var $ slide = $ (this);
			$ slide.css ({
				"margin-left": opts.width? ((opts.width - $ slide.width ()) / 2) + "px": 0,
				"margin-top": opts.height? ((opts.height - $ slide.height ()) / 2) + "px": 0
			});
		});
	}
		
	// 스트레치 컨테이너
	var reshape = (opts.containerResize || opts.containerResizeHeight) && $ cont.innerHeight () <1;
	if (reshape) {// 컨테이너에 크기가없는 경우에만이 작업을 수행하십시오. http://tinyurl.com/da2oa9
		var maxw = 0, maxh = 0;
		for (var j = 0; j <els.length; j ++) {
			var $ e = $ (els [j]), e = $ e [0], w = $ e.outerWidth (), h = $ e.outerHeight ();
			if (! w) w = e.offsetWidth || e.width || $ e.attr ( 'width');
			if (! h) h = e.offsetHeight || e.height || $ e.attr ( 'height');
			maxw = w> maxw? w : maxw;
			maxh = h> maxh? h : maxh;
		}
		if (opts.containerResize && maxw> 0 && maxh> 0)
			$ cont.css ({width : maxw + 'px', height : maxh + 'px'});
		if (opts.containerResizeHeight && maxh> 0)
			$ cont.css ({높이 : maxh + 'px'});
	}

	var pauseFlag = false; // https://github.com/malsup/cycle/issues/44
	if (opts.pause)
		$ cont.bind ( 'mouseenter.cycle', function () {
			pauseFlag = true;
			this.cyclePause ++;
			triggerPause (계속, true);
		}). bind ( 'mouseleave.cycle', function () {
				if (pauseFlag)
					this.cyclePause--;
				triggerPause (계속, true);
		});

	if (supportMultiTransitions (opts) === false)
		false를 반환;

	// 분명히 많은 사람들이 이미지의 height / width 속성없이 이미지 슬라이드 쇼를 사용합니다.
	// Cycle 2.50+에는 모든 슬라이드의 크기 정보가 필요합니다. 이 블록은이를 처리하려고 시도합니다.
	var requeue = false;
	options.requeueAttempts = options.requeueAttempts || 0;
	$ slides.each (function () {
		// 각 슬라이드의 높이 / 너비를 가져옵니다.
		var $ el = $ (this);
		this.cycleH = (opts.fit && opts.height)? opts.height : ($ el.height () || this.offsetHeight || this.height || $ el.attr ( 'height') || 0);
		this.cycleW = (opts.fit && opts.width)? opts.width : ($ el.width () || this.offsetWidth || this.width || $ el.attr ( 'width') || 0);

		if ($ el.is ( 'img')) {
			var loading = (this.cycleH === 0 && this.cycleW === 0 &&! this.complete);
			// 아직로드 중이지만 유효한 크기를 가진 이미지는 대기열에 추가하지 않습니다.
			if (로드 중) {
				if (os && opts.requeueOnImageNotLoaded && ++ options.requeueAttempts <100) {// 우리가 영원히 반복하지 않도록 재시도 횟수를 추적합니다.
					로그 (options.requeueAttempts, '- img 슬라이드가로드되지 않음, 슬라이드 쇼 대기열 :', this.src, this.cycleW, this.cycleH);
					setTimeout (function () {$ (os, oc) .cycle (options);}, opts.requeueTimeout);
					requeue = true;
					false를 반환; // 각 루프를 끊는다.
				}
				else {
					로그 ( '이미지의 크기를 결정할 수 없습니다 :'+ this.src, this.cycleW, this.cycleH);
				}
			}
		}
		참을 돌려라.
	});

	if (requeue)
		false를 반환;

	opts.cssBefore = opts.cssBefore || {};
	opts.cssAfter = opts.cssAfter || {};
	opts.cssFirst = opts.cssFirst || {};
	opts.animIn = opts.animIn || {};
	opts.animOut = opts.animOut || {};

	$ slides.not ( ': eq ('+ first + ')') .css (opts.cssBefore);
	$ ($ slides [첫째]) .css (opts.cssFirst);

	if (opts.timeout) {
		opts.timeout = parseInt (opts.timeout, 10);
		// 타임 아웃 및 속도 설정이 제정신인지 확인하십시오.
		if (opts.speed.constructor == String)
			opts.speed = $ .fx.speeds [opts.speed] || parseInt (opts.speed, 10);
		if (! opts.sync)
			opts.speed = opts.speed / 2;
		
		var buffer = opts.fx == 'none'? 0 : opts.fx == '셔플'? 500 : 250;
		while ((opts.timeout - opts.speed) <buffer) // 타임 아웃을 살균
			opts.timeout + = opts.speed;
	}
	if (opts.easing)
		opts.easeIn = opts.easeOut = opts.easing;
	if (! opts.speedIn)
		opts.speedIn = opts.speed;
	if (! opts.speedOut)
		opts.speedOut = opts.speed;

	opts.slideCount = els.length;
	opts.currSlide = opts.lastSlide = first;
	if (opts.random) {
		if (++ opts.randomIndex == els.length)
			opts.randomIndex = 0;
		opts.nextSlide = opts.randomMap [opts.randomIndex];
	}
	else if (opts.backwards)
		opts.nextSlide = opts.startingSlide === 0? (els.length-1) : opts.startingSlide-1;
	그밖에
		opts.nextSlide = opts.startingSlide> = (els.length-1)? 0 : opts.startingSlide + 1;

	// 전환 초기화 fn을 실행합니다.
	if (! opts.multiFx) {
		var init = $ .fn.cycle.transitions [opts.fx];
		if ($ .isFunction (init))
			init ($ cont, $ slides, opts);
		else if (opts.fx! = 'custom'&&! opts.multiFx) {
			로그 ( '알 수없는 전환 :'+ opts.fx, '; 슬라이드 쇼 종결');
			false를 반환;
		}
	}

	// 인공 이벤트를 발생시킵니다.
	var e0 = $ slides [처음];
	if (! opts.skipInitializationCallbacks) {
		if (opts.before.length)
			opts.before [0] .apply (e0, [e0, e0, opts, true]);
		if (opts.after.length)
			opts.after [0] .apply (e0, [e0, e0, opts, true]);
	}
	if (opts.next)
		$ (opts.next) .bind (opts.prevNextEvent, function () {return advance (opts, 1);});
	if (opts.prev)
		$ (opts.prev) .bind (opts.prevNextEvent, function () {return advance (opts, 0);});
	if (opts.pager || opts.pagerAnchorBuilder)
		buildPager (els, opts);

	exposeAddSlide (opts, els);

	return opts;
}

// 원래 선택을 저장하여 상태를 지운 후에 복원 할 수 있습니다.
함수 saveOriginalOpts (opts) {
	opts.original = {앞에 : [], 뒤에 : []};
	opts.original.cssBefore = $ .extend ({}, opts.cssBefore);
	opts.original.cssAfter = $ .extend ({}, opts.cssAfter);
	opts.original.animIn = $ .extend ({}, opts.animIn);
	opts.original.animOut = $ .extend ({}, opts.animOut);
	$ .each (opts.before, function () {opts.original.before.push (this);});
	$ .each (opts.after, function () {opts.original.after.push (this);});
}

함수 지원 다중 전환 (선택) {
	var i, tx, txs = $ .fn.cycle.transitions;
	// 여러 효과를 찾습니다.
	if (opts.fx.indexOf ( ',')> 0) {
		opts.multiFx = true;
		opts.fxs = opts.fx.replace (/ \ s * / g, ''). split ( ',');
		// 가짜 효과 이름을 버립니다.
		for (i = 0; i <opts.fxs.length; i ++) {
			var fx = opts.fxs [i];
			tx = txs [fx];
			if (! tx ||! txs.hasOwnProperty (fx) ||! $. isFunction (tx)) {
				로그 ( '알 수없는 전환 :', fx) 무시;
				opts.fxs.splice (i, 1);
				나는--;
			}
		}
		// 빈 목록이 있으면 우리는 모든 것을 버렸다!
		if (! opts.fxs.length) {
			log ( '명명 된 전환이 없습니다. 슬라이드 쇼가 종료되었습니다.');
			false를 반환;
		}
	}
	else if (opts.fx == 'all') {// 전환 목록 자동 생성
		opts.multiFx = true;
		opts.fxs = [];
		for (txs의 var p) {
			if (txs.hasOwnProperty (p)) {
				tx = txs [p];
				if (txs.hasOwnProperty (p) && $ .isFunction (tx))
					opts.fxs.push (p);
			}
		}
	}
	if (opts.multiFx && opts.randomizeEffects) {
		// 효과 선택을 무작위로 만들기 위해 fxs 배열을 munge합니다.
		var r1 = Math.floor (Math.random () * 20) + 30;
		for (i = 0; i <r1; i ++) {
			var r2 = Math.floor (Math.random () * opts.fxs.length);
			opts.fxs.push (opts.fxs.splice (r2,1) [0]);
		}
		디버그 ( '무작위로 fx 시퀀스 :', opts.fxs);
	}
	참을 돌려라.
}

// 슬라이드 쇼가 시작된 후 슬라이드를 추가하는 메커니즘 제공
function exposeAddSlide (opts, els) {
	opts.addSlide = function (newSlide, prepend) {
		var $ s = $ (newSlide), s = $ s [0];
		if (! opts.autostopCount)
			opts.countdown ++;
		els [prepend? 'unshift': 'push']] (들);
		if (opts.els)
			opts.els [prepend? 'unshift': 'push']] (들); // shuffle은 이것을 필요로합니다.
		opts.slideCount = els.length;

		// 무작위지도와 리조트에 슬라이드를 추가합니다.
		if (opts.random) {
			opts.randomMap.push (opts.slideCount-1);
			opts.randomMap.sort (function (a, b) {return Math.random () - 0.5;});
		}

		$ s.css ( 'position', 'absolute');
		$ s [prepend? 'prependTo': 'appendTo'] (opts. $ cont);

		if (prepend) {
			opts.currSlide ++;
			opts.nextSlide ++;
		}

		if (! $. support.opacity && opts.cleartype &&! opts.cleartypeNoBg)
			clearTypeFix ($ s);

		if (opts.fit && opts.width)
			$ s.width (opts.width);
		if (opts.fit && opts.height && opts.height! = 'auto')
			$ s.height (opts.height);
		s.cycleH = (opts.fit && opts.height)? opts.height : $ s.height ();
		s.cycleW = (opts.fit && opts.width)? opts.width : $ s.width ();

		$ s.css (opts.cssBefore);

		if (opts.pager || opts.pagerAnchorBuilder)
			$ .fn.cycle.createPagerAnchor (els.length-1, s, $ (opts.pager), els, opts);

		if ($ .isFunction (opts.onAddSlide))
			opts.onAddSlide ($ s);
		그밖에
			$ s.hide (); // 기본 동작
	};
}

// 내부 상태를 재설정합니다. 우리는 여러 번의 효과를 지원하기 위해 모든 패스에서이 작업을 수행합니다.
$ .fn.cycle.resetState = function (opts, fx) {
	fx = fx || opts.fx;
	opts.before = []; opts.after = [];
	opts.cssBefore = $ .extend ({}, opts.original.cssBefore);
	opts.cssAfter = $ .extend ({}, opts.original.cssAfter);
	opts.animIn = $ .extend ({}, opts.original.animIn);
	opts.animOut = $ .extend ({}, opts.original.animOut);
	opts.fxFn = null;
	$ .each (opts.original.before, function () {opts.before.push (this);});
	$ .each (opts.original.after, function () {opts.after.push (this);});

	// 다시 초기화하십시오.
	var init = $ .fn.cycle.transitions [fx];
	if ($ .isFunction (init))
		init (opts. $ cont, $ (opts.elements), opts);
};

// 이것은 주 엔진 fn이며 타임 아웃, 콜백 및 슬라이드 색인 관리를 처리합니다.
function go (els, opts, manual, fwd) {
	var p = opts. $ cont [0], curr = els [opts.currSlide], 다음 = els [opts.nextSlide];

	// 우리가 애니메이션의 중간에 있다면 opts.busy는 true입니다.
	if (manual && opts.busy && opts.manualTrump) {
		// 수동 전환 요청이 활성 전환 요청을 버리게합니다.
		디버그 ( 'manualTrump in go (), 활성 전환 중지');
		$ (els) .stop (true, true);
		opts.busy = 0;
		clearTimeout (p.cycleTimeout);
	}

	// 활성화되어있는 경우 다른 타임 아웃 기반 전환을 시작하지 않습니다.
	if (opts.busy) {
		디버그 ( '전환 활성, 새 tx 요청 무시');
		반환;
	}


	미해결 정지 요청이 있으면 // 사이클링을 중지합니다.
	if (p.cycleStop! = opts.stopCount || p.cycleTimeout === 0 &&! manual)
		반환;

	// 자동 정지 옵션을 기반으로 사이클링을 중지해야하는지 확인합니다.
	if (! manual &&! p.cyclePause &&! opts.bounce &&
		((opts.autostop && (--opts.countdown <= 0)) ||
		(opts.nowrap &&! opts.random && opts.nextSlide <opts.currSlide))) {
		if (opts.end)
			opts.end (opts);
		반환;
	}

	// 슬라이드 쇼가 일시 중지 된 경우 수동 트리거 전환 만
	var changed = false;
	if ((manual ||! p.cyclePause) && (opts.nextSlide! = opts.currSlide)) {
		changed = true;
		var fx = opts.fx;
		// 아직 슬라이드 크기가 없으면 계속 슬라이드 크기를 얻으려고 시도합니다.
		curr.cycleH = curr.cycleH || $ (curr) .height ();
		curr.cycleW = curr.cycleW || $ (curr) .width ();
		next.cycleH = next.cycleH || $ (다음). 높이 ();
		next.cycleW = next.cycleW || $ (다음) .width ();

		// 여러 전환 유형 지원
		if (opts.multiFx) {
			if (fwd && (opts.lastFx === undefined || ++ opts.lastFx> = opts.fxs.length))
				opts.lastFx = 0;
			else if (! fwd && (opts.lastFx === undefined || --opts.lastFx <0))
				opts.lastFx = opts.fxs.length - 1;
			fx = opts.fxs [opts.lastFx];
		}

		// 일회성 fx 재정의가 $ ( 'div')에 적용됩니다. cycle (3, 'zoom');
		if (opts.oneTimeFx) {
			fx = opts.oneTimeFx;
			opts.oneTimeFx = null;
		}

		$ .fn.cycle.resetState (opts, fx);

		// before 콜백을 실행합니다.
		if (opts.before.length)
			$ .each (opts.before, function (i, o) {
				if (p.cycleStop! = opts.stopCount) return;
				o.apply (다음, [curr, 다음, opts, fwd]);
			});

		// 콜백 후 단계 수행
		var after = function () {
			opts.busy = 0;
			$ .each (opts.after, function (i, o) {
				if (p.cycleStop! = opts.stopCount) return;
				o.apply (다음, [curr, 다음, opts, fwd]);
			});
			if (! p.cycleStop) {
				// 다음 전환 대기열에 넣습니다.
				queueNext ();
			}
		};

		debug ( 'tx firing ('+ fx + '); currSlide :'+ opts.currSlide + '; nextSlide :'+ opts.nextSlide);
		
		// 전환을 수행 할 준비를하십시오.
		opts.busy = 1;
		if (opts.fxFn) // fx 함수가 제공되면?
			opts.fxFn (curr, next, opts, after, fwd, manual && opts.fastOnEvent);
		else if ($ .isFunction ($. fn.cycle [opts.fx])) // fx 플러그인?
			$ .fn.cycle [opts.fx] (curr, next, opts, after, fwd, manual && opts.fastOnEvent);
		그밖에
			$ .fn.cycle.custom (curr, next, opts, after, fwd, manual && opts.fastOnEvent);
	}
	else {
		queueNext ();
	}

	if (changed || opts.nextSlide == opts.currSlide) {
		// 다음 슬라이드 계산
		var 롤;
		opts.lastSlide = opts.currSlide;
		if (opts.random) {
			opts.currSlide = opts.nextSlide;
			if (++ opts.randomIndex == els.length) {
				opts.randomIndex = 0;
				opts.randomMap.sort (function (a, b) {return Math.random () - 0.5;});
			}
			opts.nextSlide = opts.randomMap [opts.randomIndex];
			if (opts.nextSlide == opts.currSlide)
				opts.nextSlide = (opts.currSlide == opts.slideCount - 1)? 0 : opts.currSlide + 1;
		}
		else if (opts.backwards) {
			롤 = (opts.nextSlide - 1) <0;
			if (roll && opts.bounce) {
				opts.backwards =! opts.backwards;
				opts.nextSlide = 1;
				opts.currSlide = 0;
			}
			else {
				opts.nextSlide = roll? (els.length-1) : opts.nextSlide-1;
				opts.currSlide = roll? 0 : opts.nextSlide + 1;
			}
		}
		else {// 시퀀스
			roll = (opts.nextSlide + 1) == els.length;
			if (roll && opts.bounce) {
				opts.backwards =! opts.backwards;
				opts.nextSlide = els.length-2;
				opts.currSlide = els.length-1;
			}
			else {
				opts.nextSlide = roll? 0 : opts.nextSlide + 1;
				opts.currSlide = roll? els.length-1 : opts.nextSlide-1;
			}
		}
	}
	if (changed && opts.pager)
		opts.updateActivePagerLink (opts.pager, opts.currSlide, opts.activePagerClass);
	
	function queueNext () {
		// 다음 전환을 수행합니다.
		var ms = 0, timeout = opts.timeout;
		if (opts.timeout &&! opts.continuous) {
			ms = getTimeout (els [opts.currSlide], els [opts.nextSlide], opts, fwd);
         if (opts.fx == '셔플')
            ms - = opts.speedOut;
      }
		else if (opts.continuous && p.cyclePause) // 연속 된 쇼는 애프터 콜백에서 작동하지만 타이머 로직에서는 작동하지 않습니다.
			ms = 10;
		if (ms> 0)
			p.cycleTimeout = setTimeout (function () {go (els, opts, 0,! opts.backwards);}, ms);
	}
}

// 전환 후 호출됩니다.
$ .fn.cycle.updateActivePagerLink = function (호출기, currSlide, clsName) {
   $ (호출기) .each (function () {
       $ (this) .children (). removeClass (clsName) .eq (currSlide) .addClass (clsName);
   });
};

// 현재 전환에 대한 시간 초과 값을 계산합니다.
function getTimeout (curr, next, opts, fwd) {
	if (opts.timeoutFn) {
		// 사용자가 제공 한 calc fn을 호출합니다.
		var t = opts.timeoutFn.call (curr, curr, next, opts, fwd);
		while (opts.fx! = 'none'&& (t-opts.speed) <250) // 타임 아웃을 살균합니다.
			t + = opts.speed;
		디버그 ( '계산 된 시간 초과 :'+ t + '; 속도 :'+ opts.speed);
		if (t! == false)
			t를 반환;
	}
	return opts.timeout;
}

// 다음 / prev 함수를 노출 시키십시오. 호출자는 상태를 통과해야합니다.
$ .fn.cycle.next = function (opts) {advance (opts, 1); };
$ .fn.cycle.prev = function (opts) {advance (opts, 0);};

// 슬라이드를 앞으로 또는 뒤로 이동합니다.
기능 향상 (opts, moveForward) {
	var val = moveForward? 1 : -1;
	var els = opts.elements;
	var p = opts. $ cont [0], timeout = p.cycleTimeout;
	if (timeout) {
		clearTimeout (타임 아웃);
		p.cycleTimeout = 0;
	}
	if (opts.random && val <0) {
		// 이전에 표시 한 슬라이드로 다시 이동합니다.
		opts.randomIndex--;
		if (--opts.randomIndex == -2)
			opts.randomIndex = els.length-2;
		else if (opts.randomIndex == -1)
			opts.randomIndex = els.length-1;
		opts.nextSlide = opts.randomMap [opts.randomIndex];
	}
	else if (opts.random) {
		opts.nextSlide = opts.randomMap [opts.randomIndex];
	}
	else {
		opts.nextSlide = opts.currSlide + val;
		if (opts.nextSlide <0) {
			if (opts.nowrap)가 false를 반환하면;
			opts.nextSlide = els.length - 1;
		}
		else if (opts.nextSlide> = els.length) {
			if (opts.nowrap)가 false를 반환하면;
			opts.nextSlide = 0;
		}
	}

	var cb = opts.onPrevNextEvent || opts.prevNextClick; // prevNextClick은 더 이상 사용되지 않습니다.
	if ($ .isFunction (cb))
		cb (val> 0, opts.nextSlide, els [opts.nextSlide]);
	go (els, opts, 1, moveForward);
	false를 반환;
}

function buildPager (els, opts) {
	var $ p = $ (opts.pager);
	$. 각 (els, function (i, o) {
		$ .fn.cycle.createPagerAnchor (i, o, $ p, els, opts);
	});
	opts.updateActivePagerLink (opts.pager, opts.startingSlide, opts.activePagerClass);
}

$ .fn.cycle.createPagerAnchor = function (i, el, $ p, els, opts) {
	var a;
	if ($ .isFunction (opts.pagerAnchorBuilder))) {
		a = opts.pagerAnchorBuilder (i, el);
		디버그 ( 'pagerAnchorBuilder ('+ i + ', el)가 반환되었습니다 :'+ a);
	}
	그밖에
		a = '<a href="#">'+ (i + 1) + '</a>';
		
	만약)
		반환;
	var $ a = $ (a);
	// 앵커가 dom에있는 경우 reparent하지 않습니다.
	if ($ a.parents ( 'body'). 길이 === 0) {
		var arr = [];
		if ($ p.length> 1) {
			$ p.each (function () {
				var $ clone = $ a.clone (true);
				$ (this) .append ($ clone);
				arr.push ($ clone [0]);
			});
			$ a = $ (arr);
		}
		else {
			$ a.appendTo ($ p);
		}
	}

	opts.pagerAnchors = opts.pagerAnchors || [];
	opts.pagerAnchors.push ($ a);
	
	var pagerFn = function (e) {
		e.preventDefault ();
		opts.nextSlide = i;
		var p = opts. $ cont [0], timeout = p.cycleTimeout;
		if (timeout) {
			clearTimeout (타임 아웃);
			p.cycleTimeout = 0;
		}
		var cb = opts.onPagerEvent || opts.pagerClick; // pagerClick은 더 이상 사용되지 않습니다.
		if ($ .isFunction (cb))
			cb (opts.nextSlide, els [opts.nextSlide]);
		go (els, opts, 1, opts.currSlide <i); // trans를 트리거합니다.
// false를 반환합니다. // <== 버블 허용
	};
	
	if (/mouseenter|mouseover/i.test(opts.pagerEvent)) {
		$ a.hover (pagerFn, function () {/ * no-op * /});
	}
	else {
		$ a.bind (opts.pagerEvent, pagerFn);
	}
	
	if (! /^click/.test(opts.pagerEvent) &&! opts.allowPagerClickBubble)
		$ a.bind ( 'click.cycle', function () {return false;}); // 클릭 억제
	
	var cont = opts. $ cont [0];
	var pauseFlag = false; // https://github.com/malsup/cycle/issues/44
	if (opts.pauseOnPagerHover) {
		$ a.hover (
			function () { 
				pauseFlag = true;
				cont.cyclePause ++; 
				triggerPause (계속, true, true);
			}, function () { 
				if (pauseFlag)
					cont.cyclePause--; 
				triggerPause (계속, true, true);
			} 
		);
	}
};

// 현재와 다음 사이의 슬라이드 수를 계산하는 도우미 fn
$ .fn.cycle.hopsFromLast = function (opts, fwd) {
	var hops, l = opts.lastSlide, c = opts.currSlide;
	if (fwd)
		홉스 = c> l? c - l : opts.slideCount - l;
	그밖에
		홉 = c <1? l - c : l + opts.slideCount - c;
	리턴 홉;
};

// 명시 적 bg 색상을 설정하여 ie6에서 clearType 문제를 수정합니다.
// (그렇지 않으면 텍스트 슬라이드가 페이드 전환 중에 끔찍한 것처럼 보임)
function clearTypeFix ($ slides) {
	디버그 ( 'clearType background-color hack 적용');
	함수 hex (s) {
		s = parseInt (s, 10) .toString (16);
		반환 s.length <2? '0'+ s : s;
	}
	function getBg (e) {
		for (; e && e.nodeName.toLowerCase ()! = 'html'; e = e.parentNode) {
			var v = $ .css (e, 'background-color');
			if (v && v.indexOf ( 'rgb')> = 0) {
				var rgb = v.match (/ \ d + / g);
				'#'+ hex (rgb [0]) + hex (rgb [1]) + hex (rgb [2])를 반환하십시오.
			}
			if (v && v! = 'transparent')
				v를 되 돌린다.
		}
		return '#ffffff';
	}
	$ slides.each (function () {$ (this) .css ( 'background-color', getBg (this));});
}

// 다음 변환 전에 공통 소품을 재설정하십시오.
$ .fn.cycle.commonReset = function (curr, next, opts, w, h, rev) {
	$ (opts.elements) .not (curr) .hide ();
	if (typeof opts.cssBefore.opacity == 'undefined')
		opts.cssBefore.opacity = 1;
	opts.cssBefore.display = '블록';
	if (opts.slideResize && w! == false && next.cycleW> 0)
		opts.cssBefore.width = next.cycleW;
	if (opts.slideResize && h! == false && next.cycleH> 0)
		opts.cssBefore.height = next.cycleH;
	opts.cssAfter = opts.cssAfter || {};
	opts.cssAfter.display = '없음';
	$ (curr) .css ( 'zIndex', opts.slideCount + (rev === true? 1 : 0));
	$ (다음) .css ( 'zIndex', opts.slideCount + (rev === true? 0 : 1));
};

// 전환을 수행하기위한 실제 fn
$ .fn.cycle.custom = function (curr, next, opts, cb, fwd, speedOverride) {
	var $ l = $ (curr), $ n = $ (next);
	var speedIn = opts.speedIn, speedOut = opts.speedOut, easeIn = opts.easeIn, easeOut = opts.easeOut, animInDelay = opts.animInDelay, animOutDelay = opts.animOutDelay;
	$ n.css (opts.cssBefore);
	if (speedOverride) {
		if (typeof speedOverride == 'number')
			speedIn = speedOut = speedOverride;
		그밖에
			speedIn = speedOut = 1;
		easeIn = easeOut = null;
	}
	var fn = function () {
		$ n.delay (animInDelay) .animate (opts.animIn, speedIn, easeIn, function () {
			cb ();
		});
	};
	$ l.delay (animOutDelay) .animate (opts.animOut, speedOut, easeOut, function () {
		$ l.css (opts.cssAfter);
		if (! opts.sync) 
			fn ();
	});
	if (opts.sync) fn ();
};

// 트랜지션 정의 - 여기서는 페이드 만 정의되고, 트랜지션 팩은 나머지를 정의합니다
$ .fn.cycle.transitions = {
	fade : function ($ cont, $ slides, opts) {
		$ slides.not ( ': eq ('+ opts.currSlide + ')') .css ( 'opacity', 0);
		opts.before.push (function (curr, next, opts)) {
			$ .fn.cycle.commonReset (curr, next, opts);
			opts.cssBefore.opacity = 0;
		});
		opts.animIn = {opacity : 1};
		opts.animOut = {opacity : 0};
		opts.cssBefore = {위쪽 : 0, 왼쪽 : 0};
	}
};

$ .fn.cycle.ver = function () {return ver; };

원하는 경우 전역으로 재정의합니다 (모두 선택 사항 임).
$ .fn.cycle.defaults = {
    activePagerClass : 'activeSlide', // 활성 페이징 링크에 사용되는 클래스 이름
    after : null, // 전환 콜백 (표시된 요소로 설정된 범위) : function (currSlideElement, nextSlideElement, options, forwardFlag)
    allowPagerClickBubble : false, // 호출기 앵커에서 클릭 이벤트가 버블 링되는 것을 허용하거나 금지합니다.
    animIn : null, // 슬라이드가 움직이는 방식을 정의하는 속성
    animInDelay : 0, // 다음 슬라이드가 전환되기 전에 지연을 허용합니다.	
    animOut : null, // 슬라이드가 움직이는 방법을 정의하는 속성
    animOutDelay : 0, // 현재 슬라이드가 전환되기 전에 지연을 허용합니다.
    aspect : false, // 크기 조정 중 가로 세로 비율 유지, 필요한 경우 자르기 (맞춤 옵션과 함께 사용해야 함)
    autostop : 0, // X 전환 후 슬라이드 쇼를 끝내려면 true (X == 슬라이드 개수)
    autostopCount : 0, // 전환 수 (선택적으로 X를 정의하기 위해 자동 정지와 함께 사용됨)
    backward : false, // 마지막 슬라이드에서 슬라이드 쇼를 시작하고 스택을 통해 뒤로 이동하려면 true입니다.
    before : null, // 전환 콜백 (표시 할 요소로 설정된 범위) : function (currSlideElement, nextSlideElement, options, forwardFlag)
    center : null, // 각 슬라이드에 위쪽 / 왼쪽 여백을 추가하려면 true로 설정합니다 (width 및 height 옵션 사용).
    cleartype :! $. support.opacity, // clearType 수정 사항을 적용해야하는 경우 true (IE의 경우)
    cleartypeNoBg : false, // 추가로 클리어 유형 수정을 사용하지 않으려면 true로 설정합니다 (슬라이드에 배경색 설정을 적용하려면 false로 남겨 둡니다)
    containerResize : 1, // 가장 큰 슬라이드에 맞게 컨테이너 크기 조정
    containerResizeHeight : 0, // 가장 큰 슬라이드에 맞게 컨테이너 높이의 크기를 조정하지만 너비는 동적으로 두십시오.
    연속 : 0, // 현재 전환이 완료된 직후에 다음 전환을 시작하려면 true입니다.
    cssAfter : null, // 전환 후에 슬라이드의 상태를 정의한 속성
    cssBefore : null, // 전환하기 전에 슬라이드의 초기 상태를 정의하는 속성
    지연 : 0, // 첫 번째 전환에 대한 추가 지연 (힌트 : 음수 일 수 있음)
    easeIn : null, // "in"전환을위한 여유 작업
    easeOut : null, // "out"전환을위한 여유
    easing : null, // 인 / 아웃 트랜지션 모두를위한 메소드 완화
    end : null, // 슬라이드 쇼가 끝날 때 호출되는 콜백 (autostop 또는 nowrap 옵션과 함께 사용) : function (options)
    fastOnEvent : 0, // 페이저 또는 prev / next를 통해 수동으로 트리거 될 때 강제로 빠르게 전환합니다. 값 == ms 단위의 시간
    fit : 0, // 컨테이너에 맞게 슬라이드 적용
    fx : 'fade', // 전환 효과 이름 (또는 쉼표로 구분 된 이름, 예 : 'fade, scrollUp, shuffle')
    fxFn : null, // 전환을 제어하는 ​​데 사용되는 함수 : function (currSlideElement, nextSlideElement, options, afterCalback, forwardFlag)
    height : 'auto', // 컨테이너 높이 ( 'fit'옵션이 true 인 경우 슬라이드가이 높이로 설정됩니다.)
    manualTrump : true, // 수동 전환이 무시되는 대신 활성 전환을 중지하도록합니다.
    metaAttr : 'cycle', // 슬라이드 쇼의 옵션 데이터를 보유하는 데이터 속성
    next : null, // 요소, jQuery 객체 또는 다음 슬라이드의 이벤트 트리거로 사용할 요소의 jQuery 선택자 문자열
    nowrap : 0, // 슬라이드 쇼가 배치되지 않도록하려면 true입니다.
    onPagerEvent : null, // 호출기 이벤트에 대한 콜백 fn : function (zeroBasedSlideIndex, slideElement)
    onPrevNextEvent : null, // 이전 / 다음 이벤트에 대한 콜백 fn : function (isNext, zeroBasedSlideIndex, slideElement)
    호출기 : null, // 요소, jQuery 객체 또는 jQuery 선택기 문자열 (호출기 컨테이너로 사용할 요소의 경우)
    pagerAnchorBuilder : null, // 앵커 링크를 작성하기위한 콜백 fn : function (index, DOMelement)
    pagerEvent : 'click.cycle', // 호출기 탐색을 구동하는 이벤트의 이름
    일시 중지 : 0, // "마우스를 올리면 일시 중지"
    pauseOnPagerHover : 0, // 호출기 링크 위로 마우스를 가져 가면 일시 중지됩니다.
    이전 : null, // 요소, jQuery 객체 또는 이전 슬라이드의 이벤트 트리거로 사용할 요소의 jQuery 선택자 문자열
    prevNextEvent : 'click.cycle', // 이전 또는 다음 슬라이드로 수동 전환을 유도하는 이벤트
    random : 0, // 무작위의 경우 true, 시퀀스의 경우 false (fx 셔플에는 적용되지 않음)
    randomizeEffects : 1, // 여러 효과가 사용될 때 유효합니다. 이펙트의 순서를 무작위로 만들려면 true
    requeueOnImageNotLoaded : true, // 이미지 슬라이드가 아직로드되지 않은 경우 슬라이드 쇼를 다시 큐합니다.
    requeueTimeout : 250, // 다시 대기열에 대한 ms 지연
    rev : 0, // 애니메이션을 역방향으로 변환합니다 (scrollHorz / scrollVert / shuffle과 같은 효과를 지원하는 경우).
    shuffle : null, // 셔플 애니메이션 용 코드, 예 : {top : 15, left : 200}
    skipInitializationCallbacks : false, // 전환 전 발생하는 첫 번째 전 / 후 콜백을 사용하지 않으려면 true로 설정합니다.
    slideExpr : null, // 슬라이드 선택 용 표현 (모든 자식 이외의 것이 필요한 경우)
    slideResize : 1, // 모든 전환 전에 슬라이드 폭 / 높이를 고정 크기로 설정합니다.
    속도 : 1000, // 전환 속도 (모든 유효한 fx 속도 값)
    speedIn : null, // 'in'전환의 속도
    speedOut : null, // 'out'전환의 속도
    startingSlide : undefined, // 표시 할 첫 번째 슬라이드의 0부터 시작하는 인덱스입니다.
    sync : 1, // 입력 / 출력 전환이 동시에 발생해야하는 경우 true입니다.
    시간 초과 : 4000, // 슬라이드 전환 사이의 밀리 초 (자동 진행을 비활성화하려면 0)
    timeoutFn : null, // 슬라이드 당 타임 아웃 값을 결정하기위한 콜백 : function (currSlideElement, nextSlideElement, options, forwardFlag)
    updateActivePagerLink : null, // 활성 페이징 링크를 업데이트하기 위해 호출 된 콜백 fn (activePagerClass 스타일을 추가 / 제거)
    width : null // container width ( 'fit'옵션이 true 인 경우 슬라이드도이 너비로 설정됩니다.)
};

}) (jQuery);


/ *!
 * jQuery Cycle Plugin Transition 정의
 *이 스크립트는 jQuery Cycle Plugin을위한 플러그인입니다.
 * 예제 및 설명서 : http://malsup.com/jquery/cycle/
 * Copyright (c) 2007-2010 M. Alsup
 * 버전 : 2.73
 * MIT 및 GPL 라이센스에 따라 라이센스가 부여 된 듀얼 :
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * /
(함수 ($) {
"엄격한 사용";

//
//이 함수는 슬라이드 초기화 및 이름이 지정된
// 전환. 파일 크기를 저장하려면 자유롭게 파일 크기를 제거하십시오.
// 필요하지 않습니다.
//
$ .fn.cycle.transitions.none = function ($ cont, $ slides, opts) {
	opts.fxFn = 함수 (curr, next, opts, after) {
		$ (다음) .show ();
		$ (curr) .hide ();
		후();
	};
};

// cross-fade가 아닌, fadeout은 맨 위 슬라이드 만 페이드 아웃합니다.
$ .fn.cycle.transitions.fadeout = function ($ cont, $ slides, opts) {
	$ slides.not ( ': eq ('+ opts.currSlide + ')') .css ({display : 'block', 'opacity': 1});
	opts.before.push (function (curr, next, opts, w, h, rev) {
		$ (curr) .css ( 'zIndex', opts.slideCount + (rev! == true? 1 : 0));
		$ (다음) .css ( 'zIndex', opts.slideCount + (rev! == true? 0 : 1));
	});
	opts.animIn.opacity = 1;
	opts.animOut.opacity = 0;
	opts.cssBefore.opacity = 1;
	opts.cssBefore.display = '블록';
	opts.cssAfter.zIndex = 0;
};

// scrollUp / Down / Left / Right
$ .fn.cycle.transitions.scrollUp = function ($ cont, $ slides, opts) {
	$ cont.css ( 'overflow', 'hidden');
	opts.before.push ($. fn.cycle.commonReset);
	var h = $ cont.height ();
	opts.cssBefore.top = h;
	opts.cssBefore.left = 0;
	opts.cssFirst.top = 0;
	opts.animIn.top = 0;
	opts.animOut.top = -h;
};
$ .fn.cycle.transitions.scrollDown = function ($ cont, $ slides, opts) {
	$ cont.css ( 'overflow', 'hidden');
	opts.before.push ($. fn.cycle.commonReset);
	var h = $ cont.height ();
	opts.cssFirst.top = 0;
	opts.cssBefore.top = -h;
	opts.cssBefore.left = 0;
	opts.animIn.top = 0;
	opts.animOut.top = h;
};
$ .fn.cycle.transitions.scrollLeft = function ($ cont, $ slides, opts) {
	$ cont.css ( 'overflow', 'hidden');
	opts.before.push ($. fn.cycle.commonReset);
	var w = $ cont.width ();
	opts.cssFirst.left = 0;
	opts.cssBefore.left = w;
	opts.cssBefore.top = 0;
	opts.animIn.left = 0;
	opts.animOut.left = 0-w;
};
$ .fn.cycle.transitions.scrollRight = function ($ cont, $ slides, opts) {
	$ cont.css ( 'overflow', 'hidden');
	opts.before.push ($. fn.cycle.commonReset);
	var w = $ cont.width ();
	opts.cssFirst.left = 0;
	opts.cssBefore.left = -w;
	opts.cssBefore.top = 0;
	opts.animIn.left = 0;
	opts.animOut.left = w;
};
$ .fn.cycle.transitions.scrollHorz = function ($ cont, $ slides, opts) {
	$ cont.css ( 'overflow', 'hidden'). width ();
	opts.before.push (function (curr, next, opts, fwd) {
		if (opts.rev)
			fwd =! fwd;
		$ .fn.cycle.commonReset (curr, next, opts);
		opts.cssBefore.left = fwd? (next.cycleW-1) : (1-next.cycleW);
		opts.animOut.left = fwd? -curr.cycleW : curr.cycleW;
	});
	opts.cssFirst.left = 0;
	opts.cssBefore.top = 0;
	opts.animIn.left = 0;
	opts.animOut.top = 0;
};
$ .fn.cycle.transitions.scrollVert = function ($ cont, $ slides, opts) {
	$ cont.css ( 'overflow', 'hidden');
	opts.before.push (function (curr, next, opts, fwd) {
		if (opts.rev)
			fwd =! fwd;
		$ .fn.cycle.commonReset (curr, next, opts);
		opts.cssBefore.top = fwd? (1-next.cycleH) : (next.cycleH-1);
		opts.animOut.top = fwd? curr.cycleH : -curr.cycleH;
	});
	opts.cssFirst.top = 0;
	opts.cssBefore.left = 0;
	opts.animIn.top = 0;
	opts.animOut.left = 0;
};

// slideX / slideY
$ .fn.cycle.transitions.slideX = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ (opts.elements) .not (curr) .hide ();
		$ .fn.cycle.commonReset (curr, next, opts, false, true);
		opts.animIn.width = next.cycleW;
	});
	opts.cssBefore.left = 0;
	opts.cssBefore.top = 0;
	opts.cssBefore.width = 0;
	opts.animIn.width = 'show';
	opts.animOut.width = 0;
};
$ .fn.cycle.transitions.slideY = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ (opts.elements) .not (curr) .hide ();
		$ .fn.cycle.commonReset (curr, next, opts, true, false);
		opts.animIn.height = next.cycleH;
	});
	opts.cssBefore.left = 0;
	opts.cssBefore.top = 0;
	opts.cssBefore.height = 0;
	opts.animIn.height = 'show';
	opts.animOut.height = 0;
};

// 셔플
$ .fn.cycle.transitions.shuffle = function ($ cont, $ slides, opts) {
	var i, w = $ cont.css ( '오버플로', 'visible'). width ();
	$ slides.css ({left : 0, top : 0});
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, true, true);
	});
	// 한번만 속도를 조정하십시오!
	if (! opts.speedAdjusted) {
		opts.speed = opts.speed / 2; // 셔플에는 2 개의 전환이 있습니다.
		opts.speedAdjusted = true;
	}
	opts.random = 0;
	opts.shuffle = opts.shuffle || {왼쪽 : -w, 상단 : 15};
	opts.els = [];
	for (i = 0; i <$ slides.length; i ++)
		opts.els.push ($ slides [i]);

	for (i = 0; i <opts.currSlide; i ++)
		opts.els.push (opts.els.shift ());

	// custom transition fn (단맛에 대한 Benjamin Sterling의 모자 팁!)
	opts.fxFn = function (curr, next, opts, cb, fwd) {
		if (opts.rev)
			fwd =! fwd;
		var $ el = fwd? $ (curr) : $ (next);
		$ (다음) .css (opts.cssBefore);
		var count = opts.slideCount;
		$ el.animate (opts.shuffle, opts.speedIn, opts.easeIn, function () {
			var hops = $ .fn.cycle.hopsFromLast (opts, fwd);
			for (var k = 0; k <hops; k ++) {
				if (fwd)
					opts.els.push (opts.els.shift ());
				그밖에
					opts.els.unshift (opts.els.pop ());
			}
			if (fwd) {
				for (var i = 0, len = opts.els.length; i <len; i ++)
					$ (opts.els [i]) .css ( 'z-index', len-i + count);
			}
			else {
				var z = $ (curr) .css ( 'z-index');
				$ el.css ( 'z-index', parseInt (z, 10) + 1 + count);
			}
			$ el.animate ({왼쪽 : 0, 위쪽 : 0}, opts.speedOut, opts.easeOut, function () {
				$ (fwd? this : curr) .hide ();
				if (cb) cb ();
			});
		});
	};
	$ .extend (opts.cssBefore, {display : 'block', opacity : 1, top : 0, left : 0});
};

// turnUp / Down / Left / Right
$ .fn.cycle.transitions.turnUp = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, false);
		opts.cssBefore.top = next.cycleH;
		opts.animIn.height = next.cycleH;
		opts.animOut.width = next.cycleW;
	});
	opts.cssFirst.top = 0;
	opts.cssBefore.left = 0;
	opts.cssBefore.height = 0;
	opts.animIn.top = 0;
	opts.animOut.height = 0;
};
$ .fn.cycle.transitions.turnDown = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, false);
		opts.animIn.height = next.cycleH;
		opts.animOut.top = curr.cycleH;
	});
	opts.cssFirst.top = 0;
	opts.cssBefore.left = 0;
	opts.cssBefore.top = 0;
	opts.cssBefore.height = 0;
	opts.animOut.height = 0;
};
$ .fn.cycle.transitions.turnLeft = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, false, true);
		opts.cssBefore.left = next.cycleW;
		opts.animIn.width = next.cycleW;
	});
	opts.cssBefore.top = 0;
	opts.cssBefore.width = 0;
	opts.animIn.left = 0;
	opts.animOut.width = 0;
};
$ .fn.cycle.transitions.turnRight = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, false, true);
		opts.animIn.width = next.cycleW;
		opts.animOut.left = curr.cycleW;
	});
	$ .extend (opts.cssBefore, {top : 0, left : 0, width : 0});
	opts.animIn.left = 0;
	opts.animOut.width = 0;
};

// zoom
$ .fn.cycle.transitions.zoom = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, false, false, true);
		opts.cssBefore.top = next.cycleH / 2;
		opts.cssBefore.left = next.cycleW / 2;
		$ .extend (opts.animIn, {top : 0, left : 0, width : next.cycleW, height : next.cycleH});
		.extend (opts.animOut, {width : 0, height : 0, top : curr.cycleH / 2, left : curr.cycleW / 2});
	});
	opts.cssFirst.top = 0;
	opts.cssFirst.left = 0;
	opts.cssBefore.width = 0;
	opts.cssBefore.height = 0;
};

// fadeZoom
$ .fn.cycle.transitions.fadeZoom = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, false, false);
		opts.cssBefore.left = next.cycleW / 2;
		opts.cssBefore.top = next.cycleH / 2;
		$ .extend (opts.animIn, {top : 0, left : 0, width : next.cycleW, height : next.cycleH});
	});
	opts.cssBefore.width = 0;
	opts.cssBefore.height = 0;
	opts.animOut.opacity = 0;
};

// blindX
$ .fn.cycle.transitions.blindX = function ($ cont, $ slides, opts) {
	var w = $ cont.css ( 'overflow', 'hidden'). width ();
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts);
		opts.animIn.width = next.cycleW;
		opts.animOut.left = curr.cycleW;
	});
	opts.cssBefore.left = w;
	opts.cssBefore.top = 0;
	opts.animIn.left = 0;
	opts.animOut.left = w;
};
// blindY
$ .fn.cycle.transitions.blindY = function ($ cont, $ slides, opts) {
	var h = $ cont.css ( 'overflow', 'hidden'). height ();
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts);
		opts.animIn.height = next.cycleH;
		opts.animOut.top = curr.cycleH;
	});
	opts.cssBefore.top = h;
	opts.cssBefore.left = 0;
	opts.animIn.top = 0;
	opts.animOut.top = h;
};
// blindZ
$ .fn.cycle.transitions.blindZ = function ($ cont, $ slides, opts) {
	var h = $ cont.css ( 'overflow', 'hidden'). height ();
	var w = $ cont.width ();
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts);
		opts.animIn.height = next.cycleH;
		opts.animOut.top = curr.cycleH;
	});
	opts.cssBefore.top = h;
	opts.cssBefore.left = w;
	opts.animIn.top = 0;
	opts.animIn.left = 0;
	opts.animOut.top = h;
	opts.animOut.left = w;
};

// growX - 가운데 0에서 가로로 자릅니다. width
$ .fn.cycle.transitions.growX = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, false, true);
		opts.cssBefore.left = this.cycleW / 2;
		opts.animIn.left = 0;
		opts.animIn.width = this.cycleW;
		opts.animOut.left = 0;
	});
	opts.cssBefore.top = 0;
	opts.cssBefore.width = 0;
};
// growY - 가운데 0 높이에서 세로로 자릅니다.
$ .fn.cycle.transitions.growY = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, false);
		opts.cssBefore.top = this.cycleH / 2;
		opts.animIn.top = 0;
		opts.animIn.height = this.cycleH;
		opts.animOut.top = 0;
	});
	opts.cssBefore.height = 0;
	opts.cssBefore.left = 0;
};

// 양쪽 가장자리에서 수평으로 커튼을 쥐어 라.
$ .fn.cycle.transitions.curtainX = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, false, true, true);
		opts.cssBefore.left = next.cycleW / 2;
		opts.animIn.left = 0;
		opts.animIn.width = this.cycleW;
		opts.animOut.left = curr.cycleW / 2;
		opts.animOut.width = 0;
	});
	opts.cssBefore.top = 0;
	opts.cssBefore.width = 0;
};
// 커튼 Y - 세로로 양쪽 가장자리를 잡아 당긴다.
$ .fn.cycle.transitions.curtainY = function ($ cont, $ slides, opts) {
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, false, true);
		opts.cssBefore.top = next.cycleH / 2;
		opts.animIn.top = 0;
		opts.animIn.height = next.cycleH;
		opts.animOut.top = curr.cycleH / 2;
		opts.animOut.height = 0;
	});
	opts.cssBefore.height = 0;
	opts.cssBefore.left = 0;
};

// cover - 다음 슬라이드에서 다루는 curr 슬라이드
$ .fn.cycle.transitions.cover = function ($ cont, $ slides, opts) {
	var d = opts.direction || '왼쪽';
	var w = $ cont.css ( 'overflow', 'hidden'). width ();
	var h = $ cont.height ();
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts);
		opts.cssAfter.display = '';
		if (d == 'right')
			opts.cssBefore.left = -w;
		else if (d == 'up')
			opts.cssBefore.top = h;
		else if (d == 'down')
			opts.cssBefore.top = -h;
		그밖에
			opts.cssBefore.left = w;
	});
	opts.animIn.left = 0;
	opts.animIn.top = 0;
	opts.cssBefore.top = 0;
	opts.cssBefore.left = 0;
};

// uncover - 다음 슬라이드에서 curr 슬라이드가 움직입니다.
$ .fn.cycle.transitions.uncover = function ($ cont, $ slides, opts) {
	var d = opts.direction || '왼쪽';
	var w = $ cont.css ( 'overflow', 'hidden'). width ();
	var h = $ cont.height ();
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, true, true);
		if (d == 'right')
			opts.animOut.left = w;
		else if (d == 'up')
			opts.animOut.top = -h;
		else if (d == 'down')
			opts.animOut.top = h;
		그밖에
			opts.animOut.left = -w;
	});
	opts.animIn.left = 0;
	opts.animIn.top = 0;
	opts.cssBefore.top = 0;
	opts.cssBefore.left = 0;
};

// 던지기 - 위쪽 슬라이드를 이동하고 사라집니다.
$ .fn.cycle.transitions.toss = function ($ cont, $ slides, opts) {
	var w = $ cont.css ( 'overflow', 'visible'). width ();
	var h = $ cont.height ();
	opts.before.push (function (curr, next, opts)) {
		$ .fn.cycle.commonReset (curr, next, opts, true, true, true);
		// animOut이 제공되지 않은 경우 기본 토스 설정을 제공합니다.
		if (! opts.animOut.left &&! opts.animOut.top)
			$ .extend (opts.animOut, {왼쪽 : w * 2, 위쪽 : -h / 2, 불투명 : 0});
		그밖에
			opts.animOut.opacity = 0;
	});
	opts.cssBefore.left = 0;
	opts.cssBefore.top = 0;
	opts.animIn.left = 0;
};

// 지우기 - 클립 애니메이션
$ .fn.cycle.transitions.wipe = function ($ cont, $ slides, opts) {
	var w = $ cont.css ( 'overflow', 'hidden'). width ();
	var h = $ cont.height ();
	opts.cssBefore = opts.cssBefore || {};
	var 클립;
	if (opts.clip) {
		if (/l2r/.test(opts.clip))
			clip = 'rect (0px 0px'+ h + 'px 0px)';
		else if (/r2l/.test(opts.clip))
			clip = 'rect (0px'+ w + 'px'+ h + 'px'+ w + 'px)';
		else if (/t2b/.test(opts.clip))
			clip = 'rect (0px'+ w + 'px 0px 0px)';
		else if (/b2t/.test(opts.clip))
			clip = 'rect ('+ h + 'px'+ w + 'px'+ h + 'px 0px)';
		else if (/zoom/.test(opts.clip)) {
			var top = parseInt (h / 2,10);
			var left = parseInt (w / 2,10);
			clip = 'rect ('+ 위쪽 + 'px'+ 왼쪽 + 'px'+ 위쪽 + 'px'+ 왼쪽 + 'px)';
		}
	}

	opts.cssBefore.clip = opts.cssBefore.clip || 클립 || 'rect (0px 0px 0px 0px)';

	var d = opts.cssBefore.clip.match (/ (\ d +) / g);
	var = parseInt (d [0], 10), r = parseInt (d [1], 10), b = parseInt (d [2], 10), l = parseInt (d [3], 10);

	opts.before.push (function (curr, next, opts)) {
		if (curr == next) return;
		var $ curr = $ (curr), $ next = $ (next);
		$ .fn.cycle.commonReset (curr, next, opts, true, true, false);
		opts.cssAfter.display = '차단';

		var step = 1, count = parseInt ((opts.speedIn / 13), 10) - 1;
		(함수 f () {
			var tt = t? t - parseInt (step * (t / count), 10) : 0;
			var ll = l? l - parseInt (step * (l / count), 10) : 0;
			var bb = b <h? b + parseInt (단계 * ((hb) / 카운트 || 1), 10) : h;
			var rr = r <w? r + parseInt (step * (wr) / count || 1), 10) : w;
			$ next.css ({clip : 'rect ('+ tt + 'px'+ rr + 'px'+ bb + 'px'+ ll + 'px)'});
			(+++ 단계)? setTimeout (f, 13) : $ curr.css ( 'display', 'none');
		}) ();
	});
	$ .extend (opts.cssBefore, {display : 'block', opacity : 1, top : 0, left : 0});
	opts.animIn = {왼쪽 : 0};
	opts.animOut = {왼쪽 : 0};
};

}) (jQuery);