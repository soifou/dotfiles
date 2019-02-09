options =
  focus: false
  desktop: true


commands =
  activedesk: "echo $(/usr/local/bin/chunkc tiling::query -d id)"
  desktopMode: "echo $(/usr/local/bin/chunkc tiling::query --desktop mode)"
  allDesks: "echo $(/usr/local/bin/chunkc tiling::query --desktops-for-monitor 1 | tail -c 2)"
  playing: "echo $(sh ./supernerd.widget/scripts/gettrack.sh)"
  isplaying: "echo $(sh ./supernerd.widget/scripts/ismpcplaying.sh)"

command: "echo " +
         "$(#{ commands.activedesk }):::" +
         "$(#{ commands.allDesks }):::" +
         "$(#{ commands.desktopMode }):::" +
         "$(#{ commands.playing}):::" +
         "$(#{ commands.isplaying}):::"

refreshFrequency: '2s'

getIcon: ( processName ) -> # No spaces, no numbers in the app name.
  icon = switch
#Apple Apps
    when processName == "?" then "fab fa-apple"
    when processName == "Finder" then "far fa-window-restore"
    when processName == "Preview" then "fas fa-eye-dropper"
    when processName == "Safari" then "fa fa-compass"
    when processName == "iTunes" then "fab fa-itunes-note"
    when processName == "Mail" then "far fa-envelope"
    when processName == "ActivityMonitor" then "far fa-window-close"

#Microsoft Office
    when processName == "MicrosoftWord" then "fas fa-file-word"
    when processName == "MicrosoftPowerPoint" then "fas fa-file-powerpoint"
    when processName == "MicrosoftExcel" then "fas fa-file-excel"
    when processName == "MicrosoftOutlook" then "fas fa-file-outlook"

#Writing / Programming
    when processName == "Atom" then "far fa-code"
    when processName == "SublimeText" then "far fa-code"
    when processName == "Hyper" then "far fa-terminal"
    when processName == "iTerm" then "far fa-terminal"
    when processName == "Terminal" then "far fa-terminal"

#Music
    when processName == "Spotify" then "fab fa-spotify"

#Messaging
    when processName == "WhatsApp" then "fab fa-whatsapp"
    when processName == "Airmail" then "far fa-envelope"
    when processName == "Spark" then "far fa-envelope"
    else "far fa-window-maximize"

  if icon == "far fa-window-maximize"
    if processName.search("Win") > -1 || processName.search("prl") > -1 #parallels apps
      icon = "fab fa-windows"

  return icon


render: ( ) ->
  """
<div class="container">

    <div class="widg tray-button pinned red" id="desktop-mode">
        <!-- <div class="icon-container" id="desktop-mode-icon-container">
            <span id="desktop-mode"></span>
        </div> -->
    </div>

    <div class="widg tray-button pinned red" id="desktop-bullet">
        <div class="desktops"></div>
    </div>

    <div class="tray hidden" id="desktops"></div>
</div>
  """

update: ( output, domEl ) ->
  output = output.split( /:::/g )
  activedesk = output[0]
  allDesks = parseInt(output[1])
  desktopMode = output[2]
  playing = output[3]
  isplaying = output[4]

  if isplaying == "true"
    @handlePlayIcon(domEl, true)
  else
    @handlePlayIcon(domEl, false)

  $(domEl).find('#play-output').text(playing)
  # $(domEl).find('#desktop-mode').text('['+desktopMode+']')

  # deal with desktop bullet

  if options.desktop is true
    if allDesks > 0
        desksHtml = '<div class="desktop"><i class="fa fa-circle"></i></div>'.repeat(allDesks)
        $(".desktops").html(desksHtml)
        $(".desktops").find('.desktop:nth-child('+activedesk+')').addClass('current')
    # if $("#active-desktop").text != activedesk
    #     $("#active-desktop").text(activedesk)


#
# ─── HANDLES  ─────────────────────────────────────────────────────────
#

getDesktopColor: (activedesk) ->
  color = switch
    when activedesk == "1" then "red"
    when activedesk == "2" then "yellow"
    when activedesk == "3" then "blue"
    when activedesk == "4" then "magenta"

  return color

handlePlay: (domEl, status) ->
  @run "sh ./supernerd.widget/scripts/mcpplaypause.sh"
  @handlePlayIcon(domEl, status)
  @refresh()

handlePlayIcon: (domEl, status) ->
  if status == 'NULL'
    if $(domEl).find('#play-button').hasClass('fa-play')
      status = true
    else
      status = false

  if status == true
    $(domEl).find('#play-button').removeClass()
    $(domEl).find('#play-list').removeClass("hidden")
    $(domEl).find('#play-button').addClass('fas fa-pause')
  else
    $(domEl).find('#play-button').removeClass()
    $(domEl).find('#play-button').addClass('fas fa-play')
    $(domEl).find('#play-list').addClass("hidden")


handleNext: (domEl) ->
  @run "sh ./supernerd.widget/scripts/mcpnext.sh"
  @refresh()

afterRender: (domEl) ->
  $(domEl).on 'click', ".widg", (e) -> run $(e.target).attr('id')

  $(domEl).on 'mouseover', ".widg", (e) => if not $(domEl).find( $($(e.target))).hasClass('tray-button') then $(domEl).find($($(e.target))).addClass('pinned')
  $(domEl).on 'mouseout', ".widg", (e) => if not $(domEl).find( $($(e.target))).hasClass('tray-button') then $(domEl).find($($(e.target))).removeClass('pinned')

  $(domEl).on 'click', '#play', => @handlePlay(domEl, 'NULL')
  $(domEl).on 'click', '#next', => @handleNext(domEl)

  $(domEl).on 'click', ".tray-button", (e) => $(domEl).find(".tray").toggleClass('hidden')
