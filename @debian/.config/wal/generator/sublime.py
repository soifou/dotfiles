#!/usr/bin/env python

# Generate sublime color scheme based on pywal colors
# Credits: https://github.com/Brychlikov/pywal_sublime

import json
import os
import shutil


def add_rule(name, scope, **kwargs):
    """Helper function for generating color scheme entries"""
    result = {}
    result['name'] = name
    result['scope'] = scope
    result.update(kwargs)
    return result


if __name__ == '__main__':
    wal_path = os.path.join(os.environ["HOME"], '.cache/wal/colors.json')
    with open(wal_path) as file:
        wal_scheme = json.load(file)
    wal_colors = [wal_scheme['colors']['color%d' % i] for i in range(16)]

    result_scheme = {}
    result_scheme['name'] = 'Pywal'

    # Variables
    variables = {
        'background': wal_scheme['special']['background'],
        'foreground': wal_scheme['special']['foreground'],
        'cursor': wal_scheme['special']['cursor'],
        "color0": wal_scheme['colors']["color0"],
        "color1": wal_scheme['colors']["color1"],
        "color2": wal_scheme['colors']["color2"],
        "color3": wal_scheme['colors']["color3"],
        "color4": wal_scheme['colors']["color4"],
        "color5": wal_scheme['colors']["color5"],
        "color6": wal_scheme['colors']["color6"],
        "color7": wal_scheme['colors']["color7"],
        "color8": wal_scheme['colors']["color8"],
        "color9": wal_scheme['colors']["color9"],
        "color10": wal_scheme['colors']["color10"],
        "color11": wal_scheme['colors']["color11"],
        "color12": wal_scheme['colors']["color12"],
        "color13": wal_scheme['colors']["color13"],
        "color14": wal_scheme['colors']["color14"],
        "color15": wal_scheme['colors']["color15"],
        "white":   wal_scheme['colors']["color7"],
        "blue":    wal_scheme['colors']["color4"],
        "cyan":    wal_scheme['colors']["color6"],
        "green":   wal_scheme['colors']["color2"],
        "grey":    wal_scheme['colors']["color8"],
        "magenta": wal_scheme['colors']["color5"],
        "orange":  wal_scheme['colors']["color13"],
        "red":     wal_scheme['colors']["color1"],
        "yellow":  wal_scheme['colors']["color3"],
    }
    result_scheme['variables'] = variables

    # Global settings
    # see: https://www.sublimetext.com/docs/3/themes.html#variables
    global_settings = {}
    # background is usually too dark, lighten a bit
    global_settings['background'] = "var(background)"
    global_settings['foreground'] = "var(foreground)"
    global_settings['caret'] = "var(foreground)"
    global_settings['invisibles'] = "var(color1)"

    # global_settings['selection'] = "color(var(color6) l(+50%))"
    global_settings['selection'] = "color(var(color6) a(0.3))"
    # global_settings['selection_border'] = "#3392FF44"
    # global_settings['selection_corner_radius'] = "cut"
    # global_settings['selection_corner_style'] = "cut"

    # "scroll_highlight": "var(yellow)",
    # "scroll_selected_highlight": "var(green)"

    global_settings['gutter_foreground'] = "color(var(background) blend(var(grey) 60%))"
    global_settings['minimap_border'] = "var(color2)"

    # global_settings['line_highlight'] = wal_colors[2] + '2f'
    global_settings['line_highlight'] = "color(var(color2) a(0.2))"
    global_settings['line_diff_width'] = "2"
    global_settings['line_diff_added'] = "#a6cc70"
    global_settings['line_diff_modified'] = "#77a8d9"
    global_settings['line_diff_deleted'] = "#f27983"

    global_settings['active_guide'] = "color(var(color4) alpha(0.8))"
    global_settings['stack_guide'] = "color(var(color4) alpha(0.1))"

    global_settings['brackets_options'] = "underline"
    global_settings['brackets_foreground'] = "var(color3)"
    global_settings['bracket_contents_options'] = "underline"
    global_settings['bracket_contents_foreground'] = "var(color4)"

    # "brackets_options":            "foreground underline",
    # "brackets_foreground":         "var(active)",
    # "bracket_contents_options":    "foreground underline",
    # "bracket_contents_foreground": "var(active)",

    global_settings["shadow"] = "color(var(color3) blend(#000 75%))"
    global_settings["shadow_width"] = "4"

    global_settings['tags_options'] = "stippled_underline"
    global_settings['tags_foreground'] = "var(color13)"

    global_settings['popup_css'] = """
        html, body {
            font-family: monospace;
            color: """ + variables['foreground'] + """;
        }
        body#show-definitions {
            font-size: 2rem;
        }
        html {
            border-radius: 1px;
            border:1px solid """ + variables['color4'] + """;
            background-color: """ + variables['background'] + """;
        }
        body {
            padding: 1px 3px;
        }
        h1 {
            font-family: monospace;
            color: """ + variables['color4'] + """;
        }
        a {
            font-family: monospace;
            font-size: 14px;
            color: """ + variables['color2'] + """;
        }
        .error {
            /*background-color: color(var(--background) blend(red 50%) alpha(0.3));*/
        }
    """

    # Rules
    # See a list for example: https://github.com/xi-editor/syntect-resources/blob/e644db906727fce15ec5509d966aeaf95cfaeec0/Packages/PHP/syntax_test_php.php

    settings = []
    settings.append(add_rule('Comment', 'comment, meta.documentation', foreground='color(var(background) blend(grey 33%))', font_style='italic'))
    settings.append(add_rule('String', 'string, constant.other.symbol', foreground=wal_colors[4]))
    settings.append(add_rule('Number', 'constant.numeric', foreground=wal_colors[5]))
    settings.append(add_rule('Language variable', 'variable.language', foreground=wal_colors[5], font_style='italic'))
    settings.append(add_rule('Member Variable', 'variable.member', foreground=wal_colors[8]))
    settings.append(add_rule('Built-in constant', 'constant.language', foreground=wal_colors[5]))
    settings.append(add_rule('User-defined constant', 'constant.character, constant.other', foreground=wal_colors[5]))
    settings.append(add_rule('Variable', 'variable', foreground=wal_colors[8]))
    settings.append(add_rule('Storage', 'storage', foreground=wal_colors[3], font_style=''))
    settings.append(add_rule('Storage type', 'storage.type', foreground=wal_colors[6], font_style='italic'))
    settings.append(add_rule('Class name', 'entity.name.class', foreground=wal_colors[1], font_style='italic'))
    settings.append(add_rule('Inherited class', 'entity.other.inherited-class', foreground=wal_colors[1], font_style='italic underline'))
    settings.append(add_rule('Imports and packages', 'entity.name.import, entity.name.package', foreground=wal_colors[13], font_style=''))
    settings.append(add_rule('Namespaces', 'support.other.namespace, entity.name.type.namespace', foreground='color(var(color1))', font_style="bold"))
    settings.append(add_rule('Constructors', 'support.function.construct', foreground='color(var(color6))'))
    settings.append(add_rule('Constructors', 'keyword.other.new', foreground='color(var(color9))', font_style="bold"))
    settings.append(add_rule('Arrow functions', 'storage.type.function.arrow', foreground='color(var(color9))', font_style="bold"))

    # parenthese, virgule de fonction et ce qui englobe
    settings.append(add_rule('Function parameter type', 'meta.function.parameters', foreground=wal_colors[9]))

    # PHP
    settings.append(add_rule('PHP Storage Nullable', 'storage.type.nullable.php', foreground=wal_colors[8]))
    settings.append(add_rule('PHP Punctuation Dollar', 'punctuation.definition.variable.php', foreground=wal_colors[6]))
    settings.append(add_rule('Constructors', 'keyword.other.new.php', foreground='color(var(color9))', font_style="bold"))
    settings.append(add_rule('PHP Namespace Alias', 'support.other.namespace.use-as.php', foreground='color(var(background) blend(red 25%) alpha(1))'))
    settings.append(add_rule('PHP Namespaces Keyword', 'variable.language.namespace.php', foreground='color(var(background) blend(red 25%) alpha(1))'))
    settings.append(add_rule('PHP Namespaces Separator', 'punctuation.separator.inheritance.php', foreground='color(var(background) blend(red 25%) alpha(1))'))
    # HTML
    settings.append(add_rule('HTML Attribute', 'entity.other.attribute-name.class.html, entity.other.attribute-name.html', font_style='italic'))
    # YAML
    settings.append(add_rule('YAML Key', 'entity.name.tag.yaml', foreground='var(color1)'))
    settings.append(add_rule('YAML Value', 'source.yaml string.unquoted', foreground='var(color7)'))
    settings.append(add_rule('YAML Value', 'source.yaml string.quoted', foreground='var(color8)'))
    # Function
    settings.append(add_rule('Function name', 'entity.name.function', foreground=wal_colors[1]))
    settings.append(add_rule('Function name', 'entity.name - (entity.name.section | entity.name.tag | entity.name.label)', foreground=wal_colors[4], font_style='italic'))
    settings.append(add_rule('Function argument', 'variable.parameter', foreground=wal_colors[6], font_style=''))
    settings.append(add_rule('Function call', 'variable.function, variable.annotation, meta.function-call.generic, support.function.go', foreground=wal_colors[6], font_style=''))
    # Tag
    settings.append(add_rule('Tag name', 'entity.name.tag', foreground=wal_colors[3], font_style=''))
    settings.append(add_rule('Tag attribute', 'entity.other.attribute-name', foreground=wal_colors[1], font_style=''))
    # Library
    settings.append(add_rule('Library function', 'support.function', foreground=wal_colors[6], font_style=''))
    settings.append(add_rule('Library constant', 'support.constant', foreground=wal_colors[6], font_style=''))
    settings.append(add_rule('Library class/type', 'support.class, support.type', foreground=wal_colors[6], font_style='italic'))
    settings.append(add_rule('Library variable', 'support.other.variable', font_style=''))
    # Invalid
    settings.append(add_rule('Invalid', 'invalid', foreground='var(foreground)', background=wal_colors[5]))
    settings.append(add_rule('Invalid deprecated', 'invalid.deprecated', foreground='var(foreground)', background=wal_colors[4]))
    # Warnings/Errors bullets in the gutter
    settings.append(add_rule('Warning', 'markup.warning', foreground='color(var(color11) blend(yellow 90%))'))
    settings.append(add_rule('Error', 'markup.error', foreground='color(var(color9) blend(magenta 90%))'))
    # Git gutter
    settings.append(add_rule('GitGutter deleted', 'markup.deleted.git_gutter', foreground='color(var(background) blend(red 50%))'))
    settings.append(add_rule('GitGutter inserted', 'markup.inserted.git_gutter', foreground='color(var(background) blend(green 50%))'))
    settings.append(add_rule('GitGutter changed', 'markup.changed.git_gutter', foreground='color(var(background) blend(yellow 90%))'))
    settings.append(add_rule('GitGutter ignored', 'markup.ignored.git_gutter', foreground='color(var(background) blend(magenta 50%))'))
    settings.append(add_rule('GitGutter untracked', 'markup.untracked.git_gutter', foreground='color(var(background) blend(grey 50%))'))
    # Twig
    settings.append(add_rule('Twig Tagbraces', "meta.tag.template.value.twig, meta.tag.template.block.twig", foreground="var(green)"))
    settings.append(add_rule('Twig Keywords', "keyword.control.twig", foreground="var(red)"))
    settings.append(add_rule('Twig Objects', "variable.other.twig", foreground="var(magenta)"))
    settings.append(add_rule('Twig Object Properties', "variable.other.property.twig", foreground="var(foreground)"))
    settings.append(add_rule('Twig Language Constants', "constant.language.twig", foreground="var(orange)"))
    settings.append(add_rule('Twig Numerical Constants', "constant.numeric.twig", foreground="var(white)"))
    settings.append(add_rule('Twig Filters', "support.function.twig", foreground="var(blue)"))
    settings.append(add_rule('Twig User-Defined Filters', "meta.function-call.other.twig", foreground="var(orange)"))
    settings.append(add_rule('Twig Macros', "meta.function-call.twig", foreground="var(orange)"))
    # CSS
    settings.append(add_rule('CSS Properties', "support.type.property-name", foreground="var(foreground)"))
    # PlainTasks
    settings.append(add_rule('TODO Tags', "meta.tag.todo", foreground='color(var(color4))'))
    settings.append(add_rule('TODO Tags Cancelled', "meta.tag.todo.cancelled", foreground='color(var(color3))'))
    settings.append(add_rule('TODO Tags Completed', "meta.tag.todo.completed", foreground="color(var(color2))"))
    settings.append(add_rule('TODO Notes', "notes.todo", foreground="var(background)"))
    settings.append(add_rule('TODO Tags Today', 'string.other.tag.todo.today', foreground="var(foreground)"))
    settings.append(add_rule('TODO Tags High', 'string.other.tag.todo.high', foreground="var(color1)"))
    settings.append(add_rule('TODO Tags Low', 'string.other.tag.todo.low', foreground="var(color4)"))
    settings.append(add_rule('TODO Tags Critical', 'string.other.tag.todo.critical', foreground="var(color13)"))

    # settings.append(add_rule('TODO Notes', "punctuation.definition.bullet.completed", foreground='color(var(color9))', font_style='bold'))
    # punctuation.definition.bullet.pending
    # punctuation.definition.bullet.cancelled
    # meta.item.todo.cancelled
    # meta.tag.todo.completed
    # meta.tag.todo.cancelled
    # meta.punctuation.archive.todo
    # meta.punctuation.separator.todo
    # todo.italic
    # todo.bold
    # todo.url

    result_scheme['globals'] = global_settings
    result_scheme['rules'] = settings
    result_scheme['semanticClass'] = 'theme.dark.pywal'

    # Create sublime-color-scheme

    theme_path = os.path.join(
        os.environ['HOME'],
        '.config/sublime-text-3/Packages/User/Themes/Pywal.sublime-color-scheme'
    )

    with open(theme_path, 'w') as file:
        json.dump(result_scheme, file, indent=4)


    # DA UI (obsolete theme but still using it)
    da_scheme_path = os.path.join(
        os.environ['HOME'],
        ".config/sublime-text-3/Packages/User/DA Theme.sublime-settings"
    )
    if os.path.isfile(da_scheme_path):
        with open(da_scheme_path) as f:
            da_scheme = json.load(f)

        da_scheme['accent_color'] = wal_colors[4]
        with open(da_scheme_path, 'w') as file:
            json.dump(da_scheme, file, indent=4)

    # Meetio theme (https://github.com/meetio-theme/sublime-meetio-theme)
    # meetio_scheme_path = os.path.join(
    #     os.environ['HOME'],
    #     ".config/sublime-text-3/Packages/User/Meetio-Theme.sublime-theme"
    # )
    # if os.path.isfile(meetio_scheme_path):
    #     with open(meetio_scheme_path) as f:
    #         print(f)
    #         meetio_scheme = json.load(f)

    #     meetio_scheme['variables']['colorAccent'] = variables['color4']
    #     meetio_scheme['variables']['colorDark'] = variables['background']
    #     meetio_scheme['variables']['statusbarLabelColor'] = variables['foreground']
    #     meetio_scheme['variables']['sidebarBackground'] = "color("+ variables['background'] +" blend(#000 95%))"
    #     with open(meetio_scheme_path, 'w') as file:
    #         json.dump(meetio_scheme, file, indent=4)

    # A File Icon (https://packagecontrol.io/packages/A%20File%20Icon)
    afileicon_path = os.path.join(
        os.environ['HOME'],
        ".config/sublime-text-3/Packages/User/A File Icon.sublime-settings"
    )

    # We need to remove the config file !
    # try:
    #     os.remove(afileicon_path)
    # except OSError:
    #     pass

    afileicon = {}
    afileicon['color'] = wal_colors[1]
    afileicon['color_on_hover'] = wal_colors[4]
    afileicon['color_on_select'] = wal_colors[4]
    afileicon['size'] = 9
    with open(afileicon_path, 'w') as file:
        json.dump(afileicon, file, indent=4)

    # OpenUri (https://github.com/jfcherng-sublime/ST-OpenUri)
    openuri_path = os.path.realpath(os.path.join(
        os.environ['HOME'],
        ".config/sublime-text-3/Packages/User/OpenUri.sublime-settings"
    ))
    # if os.path.isfile(openuri_path):
    #     with open(openuri_path) as conf:
    #         openuri_config = json.load(conf)

    openuri_config = {}
    openuri_config['image_files'] = {}
    openuri_config['image_files']['phantom'] = "Packages/${package_name}/images/FontAwesome/link.png"
    openuri_config['image_files']['popup'] = "Packages/${package_name}/images/FontAwesome/link.png"
    openuri_config['image_colors'] = {}
    openuri_config['image_colors']['phantom'] = wal_colors[4]
    openuri_config['image_colors']['popup'] = wal_colors[4]
    with open(openuri_path, 'w') as file:
        json.dump(openuri_config, file, indent=4)
