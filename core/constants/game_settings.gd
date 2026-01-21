class_name GameSettings


const SAVE_PATH: String = 'user://idle_fusion_save.json'
const DEFAULT_SAVE: Dictionary = {
	'version': 1,
	'energy': 0,
	'generators': {
		ElementIds.Type.HYDROGEN: 1
	},
	'elements': {
		ElementIds.Type.HYDROGEN: 0
	},
}

const MAX_GENERATORS_LEVEL: int = 10
const UPGRADE_COST_MULTIPLIER: float = 1.5
const MAX_TIME_REDUCTION: float = 0.9 #90% of base production rate
const FUSION_DURATION: float = 0.1 #10 seconds
const FISSION_DURATION: float = 0.1 #5 seconds
const AMOUNT_TO_UNLOCK_GENERATOR: int = 10 #you need to have atleast 10 of the sepecific element to unlock its generator
const AMOUNT_TO_FUSE: int = 2 #amount needed to fuse an element
