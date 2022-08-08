/obj/item/circuit_component/keyboard
	display_name = "Keyboard"
	desc = "A component that allows the user to input a string"
	category = "Entity"

	var/datum/port/input/entity

	var/datum/port/input/input_name
	var/datum/port/input/input_desc

	var/datum/port/output/output

	var/datum/port/output/failure
	var/ready = TRUE

	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL

/obj/item/circuit_component/keyboard/populate_ports()
	entity = add_input_port("User", PORT_TYPE_ATOM)
	input_name = add_input_port("Input Name", PORT_TYPE_STRING)
	input_desc = add_input_port("Input Description", PORT_TYPE_STRING)
	output = add_output_port("Message", PORT_TYPE_STRING)
	trigger_output = add_output_port("Triggered", PORT_TYPE_SIGNAL)
	failure = add_output_port("On Failure", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/keyboard/input_received(datum/port/input/port)
	if(!ready)
		failure.set_output(COMPONENT_SIGNAL)
		return

	INVOKE_ASYNC(src, .proc/get_input)
	ready = FALSE

/obj/item/circuit_component/keyboard/proc/get_input()
	var/message = tgui_input_text(entity.value, input_desc.value ? input_desc.value : "", input_name.value ? input_name.value : "Keyboard", "")
	output.set_output(message)
	trigger_output.set_output(COMPONENT_SIGNAL)
	ready = TRUE

