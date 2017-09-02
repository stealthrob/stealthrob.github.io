# -*- encoding: utf-8 -*-
# stub: minima 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "minima"
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "plugin_type" => "theme" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Joel Glovier"]
  s.bindir = "exe"
  s.date = "2017-09-02"
  s.email = ["jglovier@github.com"]
  s.files = ["LICENSE.txt", "README.md", "_includes/disqus_comments.html", "_includes/footer.html", "_includes/google-analytics.html", "_includes/head.html", "_includes/header.html", "_includes/icon-github.html", "_includes/icon-github.svg", "_includes/icon-twitter.html", "_includes/icon-twitter.svg", "_layouts/default.html", "_layouts/home.html", "_layouts/page.html", "_layouts/post.html", "_sass/minima.scss", "_sass/minima/_base.scss", "_sass/minima/_layout.scss", "_sass/minima/_syntax-highlighting.scss", "assets/main.scss"]
  s.homepage = "https://github.com/jekyll/minima"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "A beautiful, minimal theme for Jekyll."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>, ["~> 3.5"])
      s.add_runtime_dependency(%q<jekyll-seo-tag>, ["~> 2.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.12"])
    else
      s.add_dependency(%q<jekyll>, ["~> 3.5"])
      s.add_dependency(%q<jekyll-seo-tag>, ["~> 2.1"])
      s.add_dependency(%q<bundler>, ["~> 1.12"])
    end
  else
    s.add_dependency(%q<jekyll>, ["~> 3.5"])
    s.add_dependency(%q<jekyll-seo-tag>, ["~> 2.1"])
    s.add_dependency(%q<bundler>, ["~> 1.12"])
  end
end
