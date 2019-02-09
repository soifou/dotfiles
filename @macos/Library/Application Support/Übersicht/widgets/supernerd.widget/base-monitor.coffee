commands =
  volume : "osascript -e 'output volume of (get volume settings)'"
  ismuted : "osascript -e 'output muted of (get volume settings)'"
  battery : "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"
  ischarging : "sh ./supernerd.widget/scripts/ischarging.sh"
  wifi: "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -e \"s/^ *SSID: //p\" -e d"
  isconnected: "echo true"
  time: "date +\"%H:%M\""


command: "echo " +
         "$(#{ commands.volume }):::" +
         "$(#{ commands.ismuted }):::" +
         "$(#{ commands.battery }):::" +
         "$(#{ commands.ischarging }):::" +
         "$(#{ commands.wifi }):::" +
         "$(#{ commands.isconnected }):::" +
         "$(#{ commands.time }):::"

refreshFrequency: '10s'

render: ( ) ->
  """
<div class="container">
<div class="tray" id="tray">
  <div class="widg toggleable" id="volume">
    <div class="icon-container" id='volume-icon-container'>
      <i id="volume-icon"></i>
      <span class="alt-text">VOL</span>
    </div>


    <!--  <span class='output'>
      <div class="bar-output toggleable" id="volume-bar-output">
        <div class="bar-output" id="volume-bar-color-output"></div>
      </div>
    </span> -->

    <span class="output" id='volume-output'></span>
  </div>

  <div class="widg toggleable" id="wifi">
    <div class="icon-container" id='wifi-icon-container'>
      <i class="fa fa-wifi"></i>
      <span class="alt-text">WFI</span>
    </div>
    <span class="output" id='wifi-output'></span>
  </div>

  <div class="widg toggleable" id="battery">
    <div class="icon-container" id='battery-icon-container'>
    <i class="battery-icon">BAT</i>
    <span class="alt-text">BAT</span>
    </div>
    <span class="output" id='battery-output'></span>
  </div>
</div>

<div class="widg pinned red tray-button" id="time">
  <span class="output pinned" id="time-output"></span>
</div>
</div>

<div class="popup container hidden" id="time-tray">

    <div class="widg theme-opt opt" id="mono">
      <div class="icon-container">
        Mono
      </div>
    </div>

  <div class="widg theme-opt opt" id="flat">
    <div class="icon-container">
      Flat
    </div>
  </div>

  <div class="widg theme-opt opt" id="float">
    <div class="icon-container">
      Float
    </div>
  </div>

  <div class="widg theme-opt opt" id="middle">
    <div class="icon-container">
      Middle
    </div>
  </div>
</div>

<div class="popup container hidden" id="time-tray">
  <div class="widg mode-opt opt" id="volume">
    <div class="icon-container">
    Volume
    </div>
  </div>

  <div class="widg mode-opt opt" id="wifi">
    <div class="icon-container">
    Wifi
    </div>
  </div>

  <div class="widg mode-opt opt" id="battery">
    <div class="icon-container">
    Battery
    </div>
  </div>
</div>

  """

update: ( output, domEl ) ->
  output = output.split( /:::/g )

  values = []

  values.volume   = output[ 0 ]
  values.ismuted  = output[ 1 ]
  values.battery = output[ 2 ]
  values.ischarging  = output[ 3 ]
  values.wifi = output[ 4 ]
  values.isconnected = output[ 5 ]
  values.time = output[ 6 ]


  controls = ['battery','volume','wifi','time']
  for control in controls
    outputId = "#"+control+"-output"
    currentValue = $("#{outputId}").value
    updatedValue = values[control]

    if updatedValue != currentValue
      $("#{ outputId }").text("#{ updatedValue }")

      if control is 'battery'
         @handleBattery( domEl, Number( values["battery"].replace( /%/g, "" ) ), values["ischarging"] )
      else if control is 'wifi' then @handleWifi( domEl, values["wifi"] )
      else if control is  'volume' then @handleVolume( domEl, Number( values["volume"]), values["ismuted"] )
      else if control is 'brightness' then @handleBrightness( domEl, values["brightness"] )

#
# ─── HANDLE BRIGHTNESS ─────────────────────────────────────────────────────────
#
handleBrightness: (domEl, brightness ) ->
  brightness = Math.round(100*brightness) + 2
  $("#brightness-output").text("#{brightness}")
  $( "#brightness-bar-color-output" ).width( "#{brightness}%" )

#
# ─── HANDLE VOLUME ─────────────────────────────────────────────────────────
#

handleVolume: ( domEl, volume, ismuted ) ->
  div = $( domEl )

  volumeIcon = switch
    when volume ==   0 then "fa-volume-off"
    when volume <=  50 then "fa-volume-down"
    when volume <= 100 then "fa-volume-up"

  #
  # div.find("#volume").removeClass('blue')
  # div.find("#volume").removeClass('red')
  #
  # if ismuted != 'true'
  #   div.find( "#volume-output").text("#{ volume }")
  #   div.find('#volume').addClass('blue')
  #   div.find('#volume-icon-container').addClass('blue')
  # else
  #   div.find( "#volume-output").text("Muted")
  #   volumeIcon = "fa-volume-off"
  #   div.find('#volume').addClass('red')
  #   div.find('#volume-icon-container').addClass('red')

  $("#volume-output").text("#{volume}")
  $( "#volume-icon" ).html( "<i class=\"fa #{ volumeIcon }\"></i>" )
  $( "#volume-bar-color-output" ).width( "#{volume}%" )


#
# ─── HANDLE BATTERY ─────────────────────────────────────────────────────────
#

handleBattery: ( domEl, percentage, ischarging ) ->
  div = $( domEl )

  batteryIcon = switch
    when percentage <=  12 then "fa-battery-empty"
    when percentage <=  25 then "fa-battery-quarter"
    when percentage <=  50 then "fa-battery-half"
    when percentage <=  75 then "fa-battery-three-quarters"
    when percentage <= 100 then "fa-battery-full"


  div.find("#battery").removeClass('green')
  div.find("#battery").removeClass('yellow')
  div.find("#battery").removeClass('red')

  if percentage >= 35
    div.find('#battery').addClass('green')
    div.find('#battery-icon-container').addClass('green')
  else if percentage >= 15
    div.find('#battery').addClass('yellow')
    div.find('#battery-icon-container').addClass('yellow')
  else
    div.find('#battery').addClass('red')
    div.find('#battery-icon-container').addClass('red')

  if ischarging == "true"
    batteryIcon = "fas fa-bolt"
  $( ".battery-icon" ).html( "<i class=\"fa #{ batteryIcon }\"></i>" )



#
# ─── HANDLE WIFI ─────────────────────────────────────────────────────────
#

handleWifi: (domEl, wifi ) ->
  $( "#wifi-output").text("#{ wifi }")

  if wifi == ''
    wifiIcon = 'fas fa-exclamation-circle'
  else
    wifiIcon = 'fa fa-wifi'
  $(domEl).find( ".wifi-icon" ).html( "<i class=\"fa #{ wifiIcon }\"></i>" )


#
# ─── ANIMATION  ─────────────────────────────────────────────────────────
#
afterRender: (domEl) ->
  $(domEl).on 'mouseover', ".widg", (e) => $(domEl).find( $($(e.target))).addClass('open')

  $(domEl).on 'mouseout', ".widg", (e) => $(domEl).find( $($(e.target))).removeClass('open')

  $(domEl).on 'click', ".widg", (e) => $(domEl).find("##{$($(e.target)).attr('id')}-tray").toggleClass('hidden') && if not $(domEl).find( $($(e.target))).hasClass('tray-button') then $(domEl).find( $($(e.target))).toggleClass('pinned')

  $(domEl).on 'mouseover', ".opt", (e) => $(domEl).find($($(e.target))).addClass('pinned')

  $(domEl).on 'mouseout', ".opt", (e) => $(domEl).find($($(e.target))).removeClass('pinned')

  $(domEl).on 'click', ".theme-opt", (e) => @run "./supernerd.widget/scripts/selectstyle #{ $(domEl).find($($(e.target))).attr('id') }"

  # $(domEl).on 'click', ".mode-opt", (e) => $(domEl).find("##{$($(e.target)).attr('id')}").toggleClass('toggle-close')
