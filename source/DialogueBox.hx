package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	var txt:FlxText;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	
	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitLeft2:FlxSprite;
	var portraitRight2:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'wump':
				FlxG.sound.playMusic(Paths.music('crashdialogue', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'crates':
				FlxG.sound.playMusic(Paths.music('crashdialogue', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'spin':
				FlxG.sound.playMusic(Paths.music('crashdialogue', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'wump':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
				if(FlxG.save.data.antialiasing)
					{
						box.antialiasing = true;
					}
			case 'crates':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
				if(FlxG.save.data.antialiasing)
					{
						box.antialiasing = true;
					}
			case 'spin':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
				if(FlxG.save.data.antialiasing)
					{
						box.antialiasing = true;
					}
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		if (PlayState.SONG.song.toLowerCase() =='senpai' || PlayState.SONG.song.toLowerCase() =='roses' || PlayState.SONG.song.toLowerCase() =='thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		else if (PlayState.SONG.song.toLowerCase() =='wump' || PlayState.SONG.song.toLowerCase() =='crates' || PlayState.SONG.song.toLowerCase() =='spin')
		{
	 		portraitLeft = new FlxSprite(-1500, 10);
	 		portraitLeft.frames = Paths.getSparrowAtlas('portraits/crashPortrait', 'shared');
	 		portraitLeft.animation.addByPrefix('enter', 'Crash Portrait Enter instance 1', 24, false);
	 		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.175));
	 		portraitLeft.updateHitbox();
	 		portraitLeft.scrollFactor.set();
	 		add(portraitLeft);
	 		portraitLeft.visible = false;
			if(FlxG.save.data.antialiasing)
			{
				portraitLeft.antialiasing = true;
			}
		
			portraitLeft2 = new FlxSprite(-50, 0);
			portraitLeft2.frames = Paths.getSparrowAtlas('portraits2/akuakuPortrait', 'shared');
			portraitLeft2.animation.addByPrefix('enter', 'AkuAku Portrait Enter instance 1', 24, false);
			portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * PlayState.daPixelZoom * 0.15));
			portraitLeft2.updateHitbox();
			portraitLeft2.scrollFactor.set();
			add(portraitLeft2);
			portraitLeft2.visible = false;
			if(FlxG.save.data.antialiasing)
				{
					portraitLeft2.antialiasing = true;
				}
		}
		
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}
		else if (PlayState.SONG.song.toLowerCase() =='wump' || PlayState.SONG.song.toLowerCase() =='crates' || PlayState.SONG.song.toLowerCase() =='spin')
		{
			portraitRight = new FlxSprite(-50, 55);
			portraitRight.frames = Paths.getSparrowAtlas('portraits/boyfriendPortrait', 'shared');
			portraitRight.animation.addByPrefix('enter', 'BF Portrait Enter instance 1', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
			if(FlxG.save.data.antialiasing)
				{
					portraitRight.antialiasing = true;
				}
			portraitRight2 = new FlxSprite(-50, 55);
			portraitRight2.frames = Paths.getSparrowAtlas('portraits2/gfPortrait', 'shared');
			portraitRight2.animation.addByPrefix('enter', 'GF Portrait Enter instance 1', 24, false);
			portraitRight2.setGraphicSize(Std.int(portraitRight2.width * PlayState.daPixelZoom * 0.15));
			portraitRight2.updateHitbox();
			portraitRight2.scrollFactor.set();
			portraitRight2.flipX = true;
			add(portraitRight2);
			portraitRight2.visible = false;
			if(FlxG.save.data.antialiasing)
				{
					portraitRight2.antialiasing = true;
				}
		}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		txt = new FlxText(500, 650, FlxG.width, "Press Shift to Skip",32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), RIGHT);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		add(txt);

		/*handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('arrow_dialogue', 'shared'));
		handSelect.setGraphicSize(35);
		add(handSelect);
		if(FlxG.save.data.antialiasing)
			{
				handSelect.antialiasing = true;
			}*/

		if (!talkingRight)
		{
			//box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 50);
		dropText.font = 'Crash-a-Like';
		dropText.color = 0xFFD89494;
		add(dropText);
		if(FlxG.save.data.antialiasing)
			{
				dropText.antialiasing = true;
			}

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 50);
		swagDialogue.font = 'Crash-a-Like';
		swagDialogue.color = 0xFF3F2021;
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns') 
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}
		if(FlxG.save.data.antialiasing)
			{
				swagDialogue.antialiasing = true;
			}
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if ((PlayState.SONG.song.toLowerCase() =='wump' || PlayState.SONG.song.toLowerCase() =='crates' || PlayState.SONG.song.toLowerCase() =='spin')) 
		{ 
			swagDialogue.color = FlxColor.BLACK;
			dropText.color = FlxColor.WHITE;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if(FlxG.keys.justPressed.SHIFT && !isEnding){

			isEnding = true;
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
				{
					box.alpha -= 1 / 5;
					txt.alpha -= 1 / 5;
					bgFade.alpha -= 1 / 5 * 0.7;
					portraitLeft.visible = false;
					portraitRight.visible = false;
					portraitLeft2.visible = false;
					portraitRight2.visible = false;
					swagDialogue.alpha -= 1 / 5;
					dropText.alpha = swagDialogue.alpha;
				}, 5);

				new FlxTimer().start(1.2, function(tmr:FlxTimer)
				{
					finishThing();
					kill();
				});

		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'wump')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						txt.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitLeft2.visible = false;
						portraitRight2.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitLeft2.visible = false;
				portraitRight2.visible = false;
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('crashText'), 0.6)];
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight2.visible = false;
				box.flipX = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				}
			case 'aku':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitRight2.visible = false;
				box.flipX = true;
				if (!portraitLeft2.visible)
				{
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('akuText'), 0.6)];
				}
			case 'gf':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				box.flipX = false;
				if (!portraitRight2.visible)
					{
						portraitRight2.visible = true;
						portraitRight2.animation.play('enter');
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
					}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
