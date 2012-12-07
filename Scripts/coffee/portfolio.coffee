isMouseOverContact = false;

$(document).ready ->
	$('#profile_pic').on 'mouseenter', fadeInInformation
	$('#profile_pic').on 'mouseenter', () ->
		isMouseOverContact = true;
	
	$('#contact').on 'mouseleave', fadeOutInformation
	$('#contact').on 'mouseleave', () ->
		isMouseOverContact = false;
	
	$('#links a').on 'click', (event) ->
		shiftWindow $($(this).attr 'href').position().top
		event.preventDefault()

	$(window).on 'scroll', checkIfAtBottom


	checkIfAtBottom

shiftWindow = (position) ->
	offset = 50
	scrollTo 0, (position - offset)

fadeInInformation = () ->
	$('#information').fadeIn(325)
	isMouseOverContact = true

fadeOutInformation = () ->
	$('#information').fadeOut(325)
	isMouseOverContact = false

checkIfAtBottom = () ->
	if $(window).scrollTop() == $(document).height() - $(window).height()
		$('#contact').off 'mouseleave', fadeOutInformation
		$('#information').fadeIn(325)
	else
		$('#contact').on 'mouseleave', fadeOutInformation
		if not isMouseOverContact
			$('#information').fadeOut(325)