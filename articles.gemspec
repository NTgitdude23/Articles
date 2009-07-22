# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{articles}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve England"]
  s.date = %q{2009-07-22}
  s.email = %q{steve@wearebeef.co.uk}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/admin/articles_controller.rb",
     "app/controllers/admin/categories_controller.rb",
     "app/controllers/admin/comments_controller.rb",
     "app/controllers/articles_controller.rb",
     "app/controllers/comments_controller.rb",
     "app/helpers/articles_helper.rb",
     "app/helpers/comments_helper.rb",
     "app/models/article.rb",
     "app/models/category.rb",
     "app/models/comment.rb",
     "app/views/admin/articles/index.html.erb",
     "app/views/admin/articles/preview.js.rjs",
     "app/views/admin/articles/show.html.erb",
     "app/views/admin/categories/index.html.erb",
     "app/views/admin/categories/show.html.erb",
     "app/views/admin/comments/index.html.erb",
     "app/views/articles/_article.html.erb",
     "app/views/articles/index.html.erb",
     "app/views/articles/index.rss.builder",
     "app/views/articles/show.html.erb",
     "app/views/comments/_comment.html.erb",
     "app/views/comments/_form.html.erb",
     "app/views/comments/new.html.erb",
     "articles.gemspec",
     "config/routes.rb",
     "generators/articles_migration/articles_migration_generator.rb",
     "generators/articles_migration/templates/migration.rb",
     "lib/articles.rb",
     "rails/init.rb",
     "test/articles_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/beef/articles}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Article/Blogging engine}
  s.test_files = [
    "test/articles_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mbleigh-acts-as-taggable-on>, [">= 0"])
      s.add_runtime_dependency(%q<jackdempsey-acts_as_commentable>, [">= 0"])
    else
      s.add_dependency(%q<mbleigh-acts-as-taggable-on>, [">= 0"])
      s.add_dependency(%q<jackdempsey-acts_as_commentable>, [">= 0"])
    end
  else
    s.add_dependency(%q<mbleigh-acts-as-taggable-on>, [">= 0"])
    s.add_dependency(%q<jackdempsey-acts_as_commentable>, [">= 0"])
  end
end
