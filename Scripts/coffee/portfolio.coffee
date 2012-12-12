isMouseOverContact = false
isMouseOverContent = false
scrollOffset = 35
contactFadeDuration = 1000

$(document).ready ->
	$('#profile_pic').on('mouseenter', fadeInInformation)
	$('#contact').on('mouseleave', fadeOutInformation)

	$('#contact').on('mouseleave', () -> isMouseOverContact = false)
	$('#contact').on('mouseenter', () -> isMouseOverContact = true)

	$('#links a').on('click', (event) ->
		shiftWindow($($(this).attr 'href').position().top)
		event.preventDefault()
	)

	$('#main_container').hover(
		(->
			isMouseOverContent = true
			$(this).addClass('toggleFocus')
			if($(window).scrollTop() != $(document).height() - $(window).height())
				$('#profile_pic').addClass('toggleProfilePicFocus')),
		(-> 
			isMouseOverContent = false
			$(this).removeClass('toggleFocus')
			$('#profile_pic').removeClass('toggleProfilePicFocus'))
	)

	$(window).on('scroll', checkIfAtBottom)
	$(window).on('scroll', determineProfilePicture)

	$(window).bind('scrollstart', () ->
		if(!isMouseOverContact)
			$('#profile_pic').addClass('toggleProfilePicFocus'))
	$(window).bind('scrollstop', () ->
		if(!isMouseOverContent)
			$('#profile_pic').removeClass('toggleProfilePicFocus'))

	checkIfAtBottom()

shiftWindow = (position) ->
	scrollTo 0, (position - scrollOffset)

fadeInInformation = () ->
	$('#profile_pic').attr('src', 'images/profile.png')
	$('#profile_pic').removeClass('toggleProfilePicFocus')
	$('#information').stop(true, true).fadeIn(contactFadeDuration)
	isMouseOverContact = true

fadeOutInformation = () ->
	$('#information').fadeOut(contactFadeDuration)
	isMouseOverContact = false
	determineProfilePicture()

checkIfAtBottom = () ->
	if ($(window).scrollTop() == $(document).height() - $(window).height())
		$('#contact').off('mouseleave', fadeOutInformation)
		$('#information').stop(true, true).fadeIn(contactFadeDuration)
	else
		$('#contact').on('mouseleave', fadeOutInformation)
		if (not isMouseOverContact)
			$('#information').fadeOut(contactFadeDuration)

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