# Scripted Simple Atoms : Git Tagger

Generates tag pills to be used inside web pages as an SVG file.

## Image pull

```bash
  docker pull scriptedatom/tag-pill-svg-generator
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `TAG_PREFIX`
    * Description : The tag prefix to use inside the image.
    * Required : `true`
* `TAG_VALUE`
    * Description : The value of the tag to generate.
    * Required : `true`
* `PILL_PREFIX_BG_COLOR`
    * Description : The color of the pill prefix background.
    * Required : `false`
    * Default : `#333333`
* `PILL_PREFIX_COLOR`
    * Description : The color of the pill prefix text.
    * Required : `false`
    * Default : `#FFFFFF`
* `PILL_VALUE_BG_COLOR`
    * Description : The color of the pill value background.
    * Required : `false`
    * Default : #007f00
* `PILL_VALUE_COLOR`
    * Description : The color of the pill value text.
    * Required : `false`
    * Default : `#FFFFFF`
* `PILL_HEIGHT_IN_PX`
    * Description : The maximum height of the pill in pixels.
    * Required : `true`
    * Default : `40`
