# For user defined colors, substitute
#     @import url(supernerd.widget/styles/colors-wal.css);
# with:
#     @import url(supernerd.widget/styles/colors.css);
#
# To change theme, substitute
#     @import url(supernerd.widget/styles/default.css);
# with the url of a css of your choice.

render: ( ) ->
  """
  <div class="">

  </div>
  """

style: """
    @import url(https://cdn.rawgit.com/tonsky/FiraCode/1.205/distr/fira_code.css);
    @import url(https://use.fontawesome.com/releases/v5.3.1/css/all.css);
    @import url(supernerd.widget/styles/colors-wal.css);
    @import url(supernerd.widget/styles/common.css);
    @import url(supernerd.widget/styles/panel.css);

    @import url(supernerd.widget/styles/applied.css);
"""


refreshFrequency: false
