isMouseOverContact = false
scrollOffset = 35
contactFadeDuration = 300

$(document).ready ->
	$('#profile_pic').on('mouseenter', fadeInInformation)
	$('#contact').on('mouseleave', fadeOutInformation)

	$('#contact').on('mouseleave', () -> isMouseOverContact = false)
	$('#contact').on('mouseenter', () -> isMouseOverContact = true)

	$('#links a').on('click', (event) ->
		shiftWindow $($(this).attr 'href').position().top
		event.preventDefault()
	)

	$('article.sticky-note').hover(
		(->
			$(this).addClass('toggleFocus')
			if($(window).scrollTop() != $(document).height() - $(window).height())
				$('#profile_pic').addClass('toggleProfilePicFocus')),
		(-> 
			$(this).removeClass('toggleFocus')
			$('#profile_pic').removeClass('toggleProfilePicFocus'))
	)

	$(window).on('scroll', checkIfAtBottom)
	$(window).on('scroll', determineProfilePicture)

	checkIfAtBottom

shiftWindow = (position) ->
	scrollTo 0, (position - scrollOffset)

fadeInInformation = () ->
	$('#profile_pic').attr('src', 'images/profile.png')
	$('#profile_pic').removeClass('toggleProfilePicFocus')
	$('#information').stop(true, true).fadeIn(contactFadeDuration)
	isMouseOverContact = true

fadeOutInformation = () ->
	$('#information').stop(true, true).fadeOut(contactFadeDuration)
	isMouseOverContact = false
	determineProfilePicture()

checkIfAtBottom = () ->
	if ($(window).scrollTop() == $(document).height() - $(window).height())
		$('#contact').off('mouseleave', fadeOutInformation)
		$('#information').stop(true, true).fadeIn(contactFadeDuration)
	else
		$('#contact').on('mouseleave', fadeOutInformation)
		if (not isMouseOverContact)
			$('#information').stop(true, true).fadeOut(contactFadeDuration)

determineProfilePicture = () ->
	projects = $('#projects').position().top - scrollOffset - 5
	work = $('#work').position().top - scrollOffset - 5
	scroll = $(window).scrollTop()
	image = $('#profile_pic')

	if (not isMouseOverContact)
		if(scroll == $(document).height() - $(window).height())
			$('#profile_pic').removeClass('toggleProfilePicFocus')
			image.attr 'src', 'images/profile.png'
		else
			if (scroll < projects)
				image.attr 'src', 'images/profile_alt_1.png'
			else if (projects <= scroll < work)
				image.attr 'src', 'images/profile_alt_2.png'
			else if (work <= scroll and scroll != $(document).height() - $(window).height())
				image.attr 'src', 'images/profile_alt_3.png'
			else
				$('#profile_pic').removeClass('toggleProfilePicFocus')
				image.attr 'src', 'images/profile.png'