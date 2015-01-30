require 'pry'
require 'lib/skeleton'

activate :skeleton
activate :autoprefixer

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir,    'assets/stylesheets'
set :js_dir,     'assets/javascripts'
set :images_dir, 'assets/images'

set :relative_links, true

###
# Bower configuration
###

# Set bower components directory in `.bowerrc`
bowerrc_dir = JSON.parse(IO.read("#{root}/.bowerrc"))['directory']
# Sprockets
ready do
  sprockets.append_path(File.join(root, bowerrc_dir))
end

###
# Compass
###
compass_config do |config|
  # Require any additional compass plugins here.
  config.add_import_path "../bower_components/foundation/scss"
  config.add_import_path File.join(root, bowerrc_dir)

  # Set this to the root of your project when deployed:
  config.http_path = "/"
  config.css_dir = "stylesheets"
  config.sass_dir = "stylesheets"
  config.images_dir = "images"
  config.javascripts_dir = "javascripts"

  # You can select your preferred output style here (can be overridden via the command line):
  # output_style = :expanded or :nested or :compact or :compressed

  # To enable relative paths to assets via compass helper functions. Uncomment:
  # relative_assets = true

  # To disable debugging comments that display the original location of your selectors. Uncomment:
  # line_comments = false


  # If you prefer the indented syntax, you might want to regenerate this
  # project again passing --syntax sass, or you can uncomment this:
  # preferred_syntax = :sass
  # and then run:
  # sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass
end

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Development-secific configuration
###

configure :development do
  # Enable Livereload
  activate :livereload, no_swf: true
  # Slim pretty-print
  Slim::Engine.set_default_options pretty: true
  # Compass configuration
  compass_config do |config|
    # config.output_style = :compact
    # config.line_comments = false
  end
end

###
# Build-specific configuration
###

configure :build do
  # Only build files prefixed by target extension (e.g. styles.css.scss)
  ignore /^.*(?<!\.css)\.scss$/
  # Ignore .coffee files
  ignore /^.*\.coffee$/

  ignore 'bower_components/**'

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end


activate :deploy do |deploy|
  deploy.method = :git

  # Uncomment following 3 lines to deploy to GH pages on master commits
  #
  # if ENV['TRAVIS']
  #   deploy.remote   = "https://#{ENV['GH_TOKEN']}:@github.com/#{ENV['TRAVIS_REPO_SLUG']}.git"
  # end

  # Optional Settings
  # deploy.build_before = true # always run 'build' before a deploy
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
