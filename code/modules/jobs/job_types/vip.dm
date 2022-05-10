/datum/job/vip
	title = JOB_VIP
	description = "Zengin ve bilindik bir iş adamısın. İş gezisi için Space Station 13'e geldin. Tadını çıkar."
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Captain"
	selection_color = "#dddddd"
	exp_granted_type = EXP_TYPE_CREW
	outfit = /datum/outfit/job/vip
	plasmaman_outfit = /datum/outfit/plasmaman
	paycheck = PAYCHECK_COMMAND

	paycheck_department = ACCOUNT_CIV

	department_for_prefs = /datum/job_department/service

	family_heirlooms = list(/obj/item/storage/toolbox/mechanical/old/heirloom, /obj/item/clothing/gloves/cut/heirloom)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	rpg_title = "VIP"


/datum/outfit/job/vip
	name = "VIP"
	jobtype = /datum/job/vip

	id_trim = /datum/id_trim/job/vip
	uniform = /obj/item/clothing/under/costume/russian_officer
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/fedora/white
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/assembly/flash/handheld

