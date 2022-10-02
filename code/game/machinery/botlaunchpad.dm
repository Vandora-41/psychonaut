/obj/machinery/botpad
	name = "Bot pad"
	desc = "A lighter version of the orbital mech pad modified to launch bots. Requires linking to a remote to function."
	icon = 'icons/obj/telescience.dmi'
	icon_state = "botpad"
	circuit = /obj/item/circuitboard/machine/botpad

	var/id = "botlauncher"
	var/obj/item/botpad_remote/connected_remote
	var/mob/living/simple_animal/bot/launched_bot

/obj/machinery/botpad/Initialize(mapload)
	. = ..()

/obj/machinery/botpad/Destroy()
	if(connected_remote)
		connected_remote.connected_botpad = null
		connected_remote = null
	return ..()

/obj/machinery/botpad/screwdriver_act(mob/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, "botpad-open", "botpad", tool)

/obj/machinery/botpad/crowbar_act(mob/user, obj/item/tool)
	..()
	if(default_deconstruction_crowbar(tool))
		return TRUE

/obj/machinery/botpad/multitool_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		return
	if(!multitool_check_buffer(user, tool))
		return
	var/obj/item/multitool/multitool = tool
	multitool.buffer = src
	to_chat(user, span_notice("You save the data in the [multitool.name]'s buffer."))
	return TRUE

/obj/machinery/botpad/proc/launch(mob/living/user)
	var/turf/reverse_turf = get_turf(user)
	var/bot_count = 0
	var/possible_bot
	for(var/atom/movable/ROI in get_turf(src))
		if(ismob(ROI))
			if(istype(ROI, /mob/living/simple_animal/bot))
				bot_count += 1
				possible_bot = ROI
			else
				to_chat(user, span_warning("There is an unidentified creature on the pad"))
				return
	if(bot_count == 1)
		launched_bot = possible_bot
		podspawn(list(
			"target" = get_turf(src),
			"path" = /obj/structure/closet/supplypod/botpod,
			"style" = STYLE_SEETHROUGH,
			"reverse_dropoff_coords" = list(reverse_turf.x, reverse_turf.y, reverse_turf.z)
		))
		use_power(active_power_usage)
	else
		to_chat(user, span_warning("There is more than one bot on the pad"))

/obj/machinery/botpad/proc/recall(mob/living/user)
	if(!launched_bot)
		to_chat(user, span_warning("No bot detected!"))
		return
	to_chat(user, span_notice("Sending the bot back to it's pad"))
	var/home = get_turf(src)
	launched_bot.call_bot(src, home)

/obj/structure/closet/supplypod/botpod
	style = STYLE_SEETHROUGH
	explosionSize = list(0,0,0,0)
	reversing = TRUE
	reverse_option_list = list("Mobs"=TRUE,"Objects"=FALSE,"Anchored"=FALSE,"Underfloor"=FALSE,"Wallmounted"=FALSE,"Floors"=FALSE,"Walls"=FALSE,"Mecha"=FALSE)
	delays = list(POD_TRANSIT = 0, POD_FALLING = 0, POD_OPENING = 0, POD_LEAVING = 0)
	reverse_delays = list(POD_TRANSIT = 15, POD_FALLING = 10, POD_OPENING = 0, POD_LEAVING = 0)
	custom_rev_delay = TRUE
	effectQuiet = TRUE
	leavingSound = 'sound/vehicles/rocketlaunch.ogg'
	close_sound = null
	pod_flags = FIRST_SOUNDS
