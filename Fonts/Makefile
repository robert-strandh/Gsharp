MFFILES= sdl.mf macros.mf charmap.mf noteheads.mf clefs.mf g_clef.mf\
         f_clef.mf c_clef.mf accents.mf dot.mf accidentals.mf sharp.mf\
	 double-sharp.mf double-flat.mf flat.mf natural.mf flags.mf\
	 rests.mf whole_rest.mf half_rest.mf quarter_rest.mf\
	  eighth_rest.mf ties.mf

all: sdl6.gf sdl8.gf sdl10.gf sdl12.gf

sdl6.gf: $(MFFILES)
	mf "\sld=6; mag=4; input sdl"
	mv sdl.2602gf sdl6.gf
	gftopk sdl6.gf
	pktogf sdl6.pk

sdl8.gf: $(MFFILES)
	mf "\sld=8; mag=4; input sdl"
	mv sdl.2602gf sdl8.gf
	gftopk sdl8.gf
	pktogf sdl8.pk

sdl10.gf: $(MFFILES)
	mf "\sld=10; mag=4; input sdl"
	mv sdl.2602gf sdl10.gf
	gftopk sdl10.gf
	pktogf sdl10.pk

sdl12.gf: $(MFFILES)
	mf "\sld=12; mag=4; input sdl"
	mv sdl.2602gf sdl12.gf
	gftopk sdl12.gf
	pktogf sdl12.pk

clean: rm -f sdl*.gf sdl*.pk sdl.log
