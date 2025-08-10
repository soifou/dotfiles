<?php

declare(strict_types=1);

return (new PhpCsFixer\Config())
    ->setRiskyAllowed(true)
    ->setRules([
        '@PSR12' => true,
        'declare_strict_types' => true,
        'linebreak_after_opening_tag' => true,
        'mb_str_functions' => true,
        'no_php4_constructor' => true,
        'no_superfluous_phpdoc_tags' => true,
        'no_unreachable_default_argument_value' => true,
        'no_useless_else' => true,
        'no_useless_return' => true,
        'phpdoc_order' => true,
        'semicolon_after_instruction' => true,
        'single_line_comment_style' => true,
        'strict_comparison' => true,
        'strict_param' => true,
    ])
    ->setCacheFile(getenv('XDG_CACHE_HOME').'/php-cs-fixer.json')
;
