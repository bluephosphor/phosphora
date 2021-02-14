enum effect {
	none,
	haste,
	slow,
	poison,
	regen,
	nvision,
	dark,
	glow,
	slip,
	buff,
	weak
}

globalvar effect_data;
effect_data[effect.none] = {};

effect_data[effect.haste] = {};

effect_data[effect.slow] = {
	oldvars: {},
	newvars: {}
};

effect_data[effect.poison] = {};

effect_data[effect.regen] = {};

effect_data[effect.nvision] = {};

effect_data[effect.dark] = {};

effect_data[effect.glow] = {};

effect_data[effect.slip] = {};

effect_data[effect.weak] = {};

function effect_reset(entity){
	
}

function effect_apply(index,entity){
	switch(index){
		case effect.slow:
			
			break;
	}
}