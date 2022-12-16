local xx = 550
local yy = 220
local xx2 = 550
local yy2 = 220
local ofs = 30
local followchars = true
local speed = 20
local spoid = 20
local i =0
local bussin = false

function onCreate()

	precacheImage('characters/DENJI SLIDE')
	precacheImage('characters/SWORD GUY')
	precacheImage('chainsaw/SWORD ROAR')
	precacheImage('characters/CHAINSAW MAN')
	precacheImage('characters/SAM FINAL')
	
	precacheImage('chainsaw/ROAR')
	precacheImage('chainsaw/SWORD ROAR')
	precacheImage('chainsaw/SWORD JUMP')
	precacheImage('chainsaw/DENJI PULL')
	
	--bigger icons
    if downscroll then
        makeAnimatedLuaSprite('chainIcon', 'chainsaw/icons/icon-chain', 635, 15)
		makeAnimatedLuaSprite('swordIcon', 'chainsaw/icons/icon-sword', 485, 15)
    else
        makeAnimatedLuaSprite('chainIcon', 'chainsaw/icons/icon-chain', 635, 570)
		makeAnimatedLuaSprite('swordIcon', 'chainsaw/icons/icon-sword', 485, 570)
    end
    addAnimationByPrefix('chainIcon', 'neutral', 'chain norm', 1, true)
    addAnimationByPrefix('chainIcon', 'lose', 'chain lose', 1, true)
    setObjectCamera('chainIcon', 'camHud')
    objectPlayAnimation('chainIcon', 'neutral', true)
	setProperty("chainIcon.alpha", 0)
	
	addAnimationByPrefix('swordIcon', 'neutral', 'sword norm', 1, true)
    addAnimationByPrefix('swordIcon', 'lose', 'sword lose', 1, true)
    setObjectCamera('swordIcon', 'camHud')
    objectPlayAnimation('swordIcon', 'neutral', true)
	setProperty("swordIcon.alpha", 0)
	
	
	makeLuaSprite('scroll1', 'chainsaw/bg/trainback', -200, -200)
	scaleObject('scroll1', 0.4, 0.4)
	makeLuaSprite('scroll2', 'chainsaw/bg/trainback', -5000, -200)
	scaleObject('scroll2', 0.4, 0.4)
	makeLuaSprite('trainbg', 'chainsaw/bg/trainbg', -200, -200)
	scaleObject('trainbg', 0.4, 0.4)
	makeLuaSprite('trainfg', 'chainsaw/bg/trainfg', -200, -200)
	scaleObject('trainfg', 0.4, 0.4)
	setScrollFactor('trainfg', 0.9, 0.9)
	
	makeAnimatedLuaSprite('mkm','chainsaw/MAKIMA BUBBLE', 200, 0)
    addAnimationByPrefix('mkm','appear','MAKIMA BUBBLE', 24, false)
	addAnimationByPrefix('mkm','bop','MAKIMA BUBBLE LOOP', 24, false)
	addAnimationByPrefix('mkm','exit','MAKIMA BUBBLE EXIT', 24, false)
	setProperty("mkm.alpha", 0)
	
	makeAnimatedLuaSprite('bobs','chainsaw/BOOB BUBBLE', -100, 0)
    addAnimationByPrefix('bobs','appear','BOOB BUBBLE', 24, false)
	addAnimationByPrefix('bobs','bop','BOOB BUBBLE LOOP', 24, false)
	addAnimationByPrefix('bobs','exit','BOOB BUBBLE EXIT', 24, false)
	setProperty("bobs.alpha", 0)
	
	makeAnimatedLuaSprite('swordappear','chainsaw/SWORD SHINE', 400, 100)
    addAnimationByPrefix('swordappear','appear','sword shine', 24, false)
	scaleObject('swordappear', 2.0,2.0)
	setProperty("swordappear.alpha", 0)
	
	makeAnimatedLuaSprite('swordROAR','chainsaw/SWORD ROAR', 0, 300)
    addAnimationByPrefix('swordROAR','appear','SWORD ROAR', 24, false)
	setProperty("swordROAR.alpha", 0)
	
	--transition shit
	makeLuaSprite('blackshit', nil, 1400, -200)
	makeGraphic('blackshit', 1600, 900, '000000')
	
	makeLuaSprite('blackbg', nil, -200, -200)
	makeGraphic('blackbg', 1600, 900, '000000')
	setProperty("blackbg.alpha", 0)
	
	--its morbin time!
	makeLuaSprite('tren', 'chainsaw/bg/train2', -200, -200)
	scaleObject('tren', 0.45, 0.45)
	makeAnimatedLuaSprite('denjimorbs','chainsaw/DENJI PULL', -100, 0)
    addAnimationByPrefix('denjimorbs','letitrip','DENJI PULL', 24, false)
	makeAnimatedLuaSprite('swordJUMPS','chainsaw/SWORD JUMP', 715, -100)
    addAnimationByPrefix('swordJUMPS','ohlawd','SWORD ANIM', 24, false)
	
	--NGAHHHH!
	makeLuaSprite('redbg', nil, -200, -200)
	makeGraphic('redbg', 1600, 900, 'D20000')
	makeAnimatedLuaSprite('sawMAN','chainsaw/ROAR', -800, -800)
    addAnimationByPrefix('sawMAN','rawr','DENJI ROAR', 24, false)
	
	addLuaSprite('scroll2', false)
	addLuaSprite('scroll1', false)
	addLuaSprite('trainbg', false)
	
	addLuaSprite('blackbg', false)
	addLuaSprite('swordappear', false)
	addLuaSprite('swordROAR', false)
	
	addLuaSprite('mkm', false)
	addLuaSprite('bobs', false)
	
	addLuaSprite('trainfg', true)
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'denji-gameover')
end

function onCreatePost()
	setProperty("dad.visible", false)
	setProperty("gf.visible", false)
	setProperty("iconP2.alpha", 0)
	
	addLuaSprite('chainIcon', true)
	addLuaSprite('swordIcon', true)
	
	for i = 0, getProperty('opponentStrums.length')-1 do
	setPropertyFromGroup('opponentStrums',i,'visible',false)
	end
end

function onUpdate(elapsed)

	--bigger icons lol
	setProperty('chainIcon.x', getProperty('iconP1.x'))
	setProperty('swordIcon.x', getProperty('iconP2.x'))
	
	setProperty('chainIcon.scale.x', getProperty('iconP1.scale.x'))
	setProperty('chainIcon.scale.y', getProperty('iconP1.scale.y'))
	setProperty('swordIcon.scale.x', getProperty('iconP2.scale.x'))
	setProperty('swordIcon.scale.y', getProperty('iconP2.scale.y'))

	if getProperty('health') >= 1.75 then
		objectPlayAnimation('chainIcon', 'neutral', true)
		objectPlayAnimation('swordIcon', 'lose', true)
	elseif getProperty('health') <= 0.3 then
		objectPlayAnimation('chainIcon', 'lose', true)
		objectPlayAnimation('swordIcon', 'neutral', true)
	elseif getProperty('health') < 1.75 and getProperty('health') > 0.3 then
		objectPlayAnimation('chainIcon', 'neutral', true)
		objectPlayAnimation('swordIcon', 'neutral', true)
	end

	--scrolling bg
	i = i + 1
	DALAPSED = elapsed/0.016
	speed = spoid*DALAPSED
	setProperty('scroll1.x',getProperty('scroll1.x')+speed)
	if getProperty('scroll1.x') > 4600 then
		setProperty('scroll1.x',-5000)
	end
	setProperty('scroll2.x',getProperty('scroll2.x')+speed)
	if getProperty('scroll2.x') > 4600 then
		setProperty('scroll2.x',-5000)
	end
	
	--shmooving camera woa
	if followchars == true then
		if mustHitSection == false then
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy)
				end
			else
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
		  end	
	end
end

function onEvent(name, value1, value2)
	if name == "Thonk" then
		lul = tonumber(value1)
		wonk = tonumber(value2)
		
		if lul == 0 then
			if wonk == 0 then
				objectPlayAnimation('mkm','appear',false)
				setProperty("mkm.alpha", 1)
				runTimer('appearcomplete', 0.2, 1)
			elseif wonk == 1 then
				objectPlayAnimation('mkm','exit',false)
				runTimer('noboobs', 0.2, 1)
			end
		elseif lul == 1 then
			if wonk == 0 then
				objectPlayAnimation('bobs','appear',false)
				setProperty("bobs.alpha", 1)
				runTimer('appearcomplete2', 0.2, 1)
			elseif wonk == 1 then
				objectPlayAnimation('bobs','exit',false)
				runTimer('noboobs2', 0.2, 1)
			end
		end
	end
	
	if name == "Transition" then --the blackstuff
		addLuaSprite('blackshit', true)
		doTweenX('blackTween', 'blackshit', -200, 0.7, 'cubeIn')
		doTweenAlpha('hudTime', 'camHUD', 0, 0.3, 'linear')
	end
	
	if name == 'ROAR' then --sword devil appears
		removeLuaSprite('swordappear')
		runTimer('ROARR', 0.6, 1)
		setProperty("swordROAR.alpha", 1)
		doTweenY('swordROARTweenY', 'swordROAR', -300, 0.7, 'cubeIn')
	end
	
	if name == 'revvinit' then --denji popsup
		triggerEvent('Change Character', 'bf', 'denjislide')
		triggerEvent('Change Character', 'dad', 'sword')
		setProperty('dad.alpha', 0)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.y', -100)
		setProperty('dad.x', -100)
		setProperty('boyfriend.y', 100)
		setProperty('boyfriend.x', 1050)
		doTweenY('denjiSlideTweenY', 'boyfriend', -70, 1, 'cubeIn')
		doTweenX('denjiSlideTweenX', 'boyfriend', 650, 1, 'cubeIn')
	end
	
	if name == 'Dad Appear' then --they start funkin baby
		doTweenAlpha('hudTime', 'camHUD', 1, 0.3, 'linear')
		setProperty("swordIcon.alpha", 1)
		removeLuaSprite('swordROAR')
		setProperty('dad.alpha', 1)
		setProperty("dad.visible", true)
		for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums',i,'visible',true)
		end
		bussin = true
	end
	
	if name == 'Morbed' then --he then morbed sword devil
		cameraFlash('camHUD', 'FFFFFF', 0.3, false)
		doTweenAlpha('hudTime', 'camHUD', 0, 0.3, 'linear')
        addLuaSprite('tren', true)
		addLuaSprite('denjimorbs', true)
		objectPlayAnimation('denjimorbs', 'letitrip', false)
		addLuaSprite('swordJUMPS', true)
		objectPlayAnimation('swordJUMPS', 'ohlawd', false)
	end
	
	if name == 'ANGERY' then --LET IT RIIIIIIIIIIIIIP
		cameraFlash('camHUD', 'FFFFFF', 0.2, false)
        addLuaSprite('redbg', true)
		addLuaSprite('sawMAN', true)
		objectPlayAnimation('sawMAN', 'rawr', false)
	end
	
	if name == 'getthefuckinhudback' then --make the hud appear early, also flip the notes lol
		doTweenAlpha('hudTime', 'camHUD', 1, 0.3, 'linear')
		if not middlescroll then
			noteTweenX('bfTween1', 4, 90, 0.5, 'linear')
			noteTweenX('bfTween2', 5, 205, 0.5, 'linear')
			noteTweenX('bfTween3', 6, 315, 0.5, 'linear')
			noteTweenX('bfTween4', 7, 425, 0.5, 'linear')
			noteTweenX('dadTween1', 0, 730, 0.5, 'linear')
			noteTweenX('dadTween2', 1, 845, 0.5, 'linear')
			noteTweenX('dadTween3', 2, 955, 0.5, 'linear')
			noteTweenX('dadTween4', 3, 1065, 0.5, 'linear')
		end
	end
	
	if name == 'backtobasics' then --we live
		triggerEvent('Change Character', 'bf', 'chainsawman')
		triggerEvent('Change Character', 'dad', 'sword-devil')
		cameraFlash('camHUD', 'FFFFFF', 0.1, false)
		setProperty('dad.y', -100)
		setProperty('dad.x', 600)
		setProperty('boyfriend.y', -100)
		setProperty('boyfriend.x', 0)
		removeLuaSprite('tren')
		removeLuaSprite('denjimorbs')
		removeLuaSprite('swordJUMPS')
		removeLuaSprite('redbg')
		removeLuaSprite('sawMAN')
		removeLuaSprite('blackbg')
		setProperty("iconP1.alpha", 0)
		setProperty("chainIcon.alpha", 1)
		setProperty("trainfg.alpha", 1)
		spoid = 40
	end
end

function onTweenCompleted(tag) 
	
	if tag == 'blackTween' then
		setProperty("trainfg.alpha", 0)
		setProperty("blackbg.alpha", 1)
		objectPlayAnimation('swordappear','appear',false)
		setProperty("swordappear.alpha", 1)
		setProperty('blackshit.x', 1400)
		setProperty("boyfriend.alpha", 0)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'appearcomplete' then
		objectPlayAnimation('mkm','bop',false)
	end
	if tag == 'noboobs' then
		removeLuaSprite('mkm')
	end
	if tag == 'appearcomplete2' then
		objectPlayAnimation('bobs','bop',false)
	end
	if tag == 'noboobs2' then
		removeLuaSprite('bobs')
	end
	if tag == 'ROARR' then
		objectPlayAnimation('swordROAR','appear',false)
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote) --goofy ahh health drain
	if getProperty("health") > 0.02 and bussin == true then
			setProperty("health", getProperty("health") - 0.02)
	end
end