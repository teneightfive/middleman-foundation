Middleman Foundation Template
=============================

Static site starter template for [Middleman](http://middlemanapp.com).

###### Preprocessing
- [Slim](http://slim-lang.com) *[for html]*
- [SASS](http://sass-lang.com) *[for css]*
- [CoffeeScript](http://coffeescript.org) *[for js]*

###### Tools
- [Bower](http://bower.io) *[js package management]*
- [Foundation](http://foundation.zurb.com/docs/) *[sass helpers/mixins]*
- [Middleman Deploy](https://github.com/karlfreeman/middleman-deploy) *[deployment/hosting]*

## Getting Started

1. Install Middleman

  ```
  gem install middleman
  ```

2. Install template

  ```
  (export D=~/.middleman/middleman-foundation; mkdir -p ${D}; curl -L https://github.com/teneightfive/middleman-foundation/tarball/master | tar --strip-components=1 -C ${D} -xf-)
  ```

3. Start your project

  ```
  cd ~/path/to/your/project
  middleman init PROJECT_NAME --template=middleman-foundation
  ```

## Using Bower

1. Find and install the packages you need...

  ```
  $ bower search PACKAGE_NAME
  $ bower install ACTUAL_PACKAGE_NAME -S
  ```

2. Include the assets in your js/css files (paths relative to the root 'bower' directory )

  `#=require 'folder/file'` - *for js files*
  
  `@import 'folder/file'` - *for css files*

## Deploying to GitHub Pages

`$ middleman deploy`

There is an option to add a [Travis CI](https://travis-ci.org/) job to automatically deploy on commits to master. 

- Uncomment travis settings in `Deploy config` section of `config.rb`
- Rename `sample.travis.yml` to `.travis.yml`
- Add your GitHub API token as a [secure environment variable](http://docs.travis-ci.com/user/environment-variables/#Secure-Variables) as `GH_TOKEN` to the `travis.yml` file
- Set up travis hooks


### Template helpers

#### `resources_for`
List resources for a specific path.

Parameters:
  - `path` - required.
  - `ext` - optional. Resource extension (defaults to `html`)
  - `exclude_indexes` - optional. Whether to exclude directory indexes from the list of resources (defaults to `false`)

#### `local_data`
Load local data from YAML or JSON file. e.g. `= local_data '../data.yaml'

Parameters:
  - `path` - required. Relative path to YAML file, including file extension.

#### `get`
Make an HTTP GET request using [Rest Client](https://github.com/rest-client/rest-client).

Parameters:
  - `url` - required. Resource URL.
  - `options` - optional. Headers or parameters.  
     e.g. `= get 'https://user:password@api.example.com/resource', { params: { filter: 'desc' }, accept: 'application/json' }`

#### `post`
Make an HTTP POST request using [Rest Client](https://github.com/rest-client/rest-client).

Parameters:
  - `url` - required. Resource URL.
  - `params` - optional. Parameters. Passing Ruby hash will force Content-Type to `application/x-www-form-urlencoded`. To use custom Content-Type quote passed JSON.  
     e.g. `= post 'https://user:password@api.example.com/resource', '{ "name": "Bob" }'`
  - `headers` - optional. Custom headers  
     e.g. `= post 'https://user:password@api.example.com/resource', '{}' { accept: 'application/json' }`

### Frontmatter

There are two special parameters set in [Middleman’s Frontmatter](http://middlemanapp.com/basics/frontmatter/):
`javascripts` and `stylesheets`. When set, JavaScript and stylesheets are inserted in that particular page.

This is useful for prototyping or creating a page that is different from all other pages in style or functionality (or both).

The parameters can be plural or singular and can take YAML list, single name or comma separated list of names. Paths can be absolute or relative as well as external URL. If prefixed with `/` `source` directory will be used as root. Dot-prefixes are accepted for relative paths. `.css`, `.js` extensions are optional. Files can be in CoffeeScript or Sass (save as `name.css.scss`), Middleman will take care of finding and processing the file.

For example:

```yaml
---
  stylesheet: ../style
  javascripts: my-app.js, /assets/javascripts/global
---

---
  stylesheets:
    - http://static.bbci.co.uk/h4base/0.209.13/style/h4base.css
    - ./bbc-local
  javascripts:
    - ../../above.js
    - further/down.js
---
```
