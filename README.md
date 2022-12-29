# Csvbuilder::Dynamic::Columns::Exporter

[Csvbuilder::Dynamic::Columns::Exporter](https://github.com/joel/csvbuilder-dynamic-columns-exporter) is part of the [csvbuilder-collection](https://github.com/joel/csvbuilder)

The Dynamic Columns Exporter contains the implementation for exporting a collection of objects within a variable group as a CSV file.

For instance, any object belonging to categories.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add csvbuilder-dynamic-columns-exporter

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install csvbuilder-dynamic-columns-exporter

## Usage

Let's consider a Developer with languages skill.

```ruby
class UserCsvRowModel
  include Csvbuilder::Model
  include Csvbuilder::Export

  column :name, header: "Developer"

  dynamic_column :skills

  def skill(skill_name)
    source_model.skills.where(name: skill_name).exists? ? "1" : "0"
  end
end
```

For each Row, a method called by the singular version name of the declared Dynamic Columns will be called to determine the cell's value. In our example: `skill` must be implemented in the Exporter Model.

The `source_model` is provided and accessible within this method. In our example, it is the `User`. The File Exporter appends this object to the Row.

The dynamic part of the headers must be provided through the context under the same key name as the declared Dynamic Columns, here `skills`.

```ruby
context = { skills: ["Ruby", "Python", "Javascript"] }

exporter  = Csvbuilder::Export::File.new(UserCsvExportModel, context)

exporter.headers
# => ["Developer", "Ruby", "Python", "Javascript"]

sub_context = {} # it merged to the context

exporter.generate do |csv|
  User.all.each do |user|
    csv.append_model(user, sub_context) # user here is the source_model.
  end
end

exporter.to_s
# => "Developer,Ruby,Python,Javascript\Bob,1,0,0\n"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joel/csvbuilder-dynamic-columns. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/csvbuilder-dynamic-columns/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Csvbuilder::Dynamic::Columns project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csvbuilder-dynamic-columns/blob/main/CODE_OF_CONDUCT.md).
