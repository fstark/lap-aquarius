go: src/map.bin
	mame aquarius -cart1 src/map.bin -ui_active -skip_gameinfo -resolution 1024x768

debug: src/map.bin
	mame -debug aquarius -cart1 src/map.bin -ui_active -resolution 1024x768

clean:
	rm -f src/map.p src/map.bin src/sample.inc src/sprites.inc

src/map.bin: src/map.p
	p2bin src/map.p

src/map.p: src/map.asm src/sprites.inc src/sample.inc src/splash.inc src/shop.inc src/title.inc
	cd src && asl -cpu z80 map.asm

src/sprites.inc: assets/sprites.json tools/json2asm.py
	python tools/json2asm.py SPRITES < assets/sprites.json > src/sprites.inc

src/sample.inc: assets/sample.json tools/json2asm.py
	python tools/json2asm.py SAMPLE < assets/sample.json > src/sample.inc

src/splash.inc: assets/splash.json tools/json2asm.py
	python tools/json2asm.py SPLASH < assets/splash.json > src/splash.inc

src/shop.inc: assets/shop.json tools/json2asm.py
	python tools/json2asm.py SHOP < assets/shop.json > src/shop.inc

src/title.inc: assets/title.json tools/json2asm.py
	python tools/json2asm.py TITLE < assets/title.json > src/title.inc
