$ ->
  SMALL_HEIGHT = 100
  BIG_HEIGHT   = 240
  ANIMATION_DURATION_OPEN  = 500
  ANIMATION_DURATION_CLOSE = 100

  $noteInputContainer = $ '#note-input-form'
  $notesList = $ '#notes-list'
  $noteNewForm = $noteInputContainer.find 'form'
  $noteHeader = $ '#note_header'
  $noteContent = $ '#note_content'
  $noteSubmitButton = $noteInputContainer.find '.button'

  $noteNewForm.on "ajaxSuccess", (e, data, status, xhr) ->
    $noteInputContainer.animate({height: SMALL_HEIGHT}, ANIMATION_DURATION_CLOSE)
    $noteContent.val('')
    $noteContent.height(0)
    $noteContent.css('display', 'none')
    #debugger
    $notesList.find('li').first().prepend(data.html)
    alert "Yes!"

  # $noteNewForm.on "ajax:error", (e, xhr, status) ->
  #   alert xhr.responseText
  #   $notesList.find('li').first().prepend(xhr.responseText)


  saveNewNote = ->
    $noteNewForm.submit()

  $noteHeader.on 'keydown', (e) ->
    if (e.ctrlKey || e.metaKey) && e.keyCode == 13
      saveNewNote.call()
    if !(e.ctrlKey || e.metaKey) && e.keyCode == 13 #=>KEY_CODES.ENTER
      e.preventDefault()
      $noteInputContainer.animate({height: BIG_HEIGHT}, ANIMATION_DURATION_OPEN, ->
        $noteContent.focus())
      $noteContent.height(100)
      $noteContent.css('display', 'block')
  
  $noteContent.on 'keydown', (e) ->
    if (e.ctrlKey || e.metaKey) && e.keyCode == 13
      saveNewNote.call()
    if e.keyCode == 27 #=>KEY_CODES.ESCAPE
      $noteHeader.focus()
      $noteInputContainer.animate({height: SMALL_HEIGHT}, ANIMATION_DURATION_CLOSE)
      $noteContent.val('')
      $noteContent.height(0)
      $noteContent.css('display', 'none')

  #     $ ->
  # SMALL_HEIGHT = 45
  # BIG_HEIGHT   = 150
  # ANIMATION_DURATION_OPEN  = 500
  # ANIMATION_DURATION_CLOSE = 100

  # $ticketInputContainer = $ '#ticket-new-input'
  # $ticketNewFormContainer = $ '#ticket-new-form'
  # $ticketTypeButtons = $ticketNewFormContainer.find '.button'
  # $ticketNewForm = $ticketNewFormContainer.find 'form'
  # $ticketIssueType = $ '#ticket_issue_type'
  # $ticketIssueDescription = $ '#ticket_issue_description'
  # $ticketDetailedDescription = $ '#ticket_detailed_description'

  # $ticketNewForm.on "ajax:success", (e, data, status, xhr) ->
  #   $ticketInputContainer.animate({height: SMALL_HEIGHT}, ANIMATION_DURATION_CLOSE)

  # saveNewTicket = ->
  #   issueType = $(@).data 'type'
  #   $ticketIssueType.val issueType
  #   $ticketNewForm.submit()

  # $ticketTypeButtons.on 'click', (e) ->
  #   e.preventDefault()
  #   saveNewTicket.call(@)

  # $ticketTypeButtons.on 'keypress', (e) ->
  #   e.preventDefault()
  #   if e.keyCode == KEY_CODES.ENTER or e.keyCode == KEY_CODES.SPACE
  #     saveNewTicket.call(@)

  # $ticketIssueDescription.on 'keypress', (e) ->
  #   if e.keyCode == KEY_CODES.ENTER
  #     e.preventDefault()
  #     $ticketInputContainer.animate({height: BIG_HEIGHT}, ANIMATION_DURATION_OPEN, ->
  #       $ticketDetailedDescription.focus())
  #     $ticketDetailedDescription.height(80)
  #     $ticketDetailedDescription.css('display', 'block')
  
  # $ticketDetailedDescription.on 'keyup', (e) ->
  #   if e.keyCode == KEY_CODES.ESCAPE
  #     $ticketIssueDescription.focus()
  #     $ticketInputContainer.animate({height: SMALL_HEIGHT}, ANIMATION_DURATION_CLOSE)
  #     $ticketDetailedDescription.val('')
  #     $ticketDetailedDescription.height(45)
  #     $ticketDetailedDescription.css('display', 'none')