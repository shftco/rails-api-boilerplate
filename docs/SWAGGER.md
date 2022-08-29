# Swagger Documentation
This boilerplate is using `swagger-blocks` gem for creating swagger documentation with Ruby on Rails application.

[TUTORIAL](https://duetcode.io/rails-api-only-course/api-documentation-with-swagger)

## Folder Structure
    .
    ├── ...
    ├── app
    │   ├── ...
    │   ├── controllers
    │   ├── swagger_docs
    │   │   ├── controllers
    │   │   ├── inputs
    │   │   ├── models
    │   │   ├── parameters
    │   │   ├── responses

---
### Sample controller
```ruby
# frozen_string_literal: true

module Controllers
  class CitiesController
    include Swagger::Blocks

    swagger_path '/cities/{city_id}' do
      operation :get do
        key :summary, 'Return city with by id'
        key :description, 'Return city with by id'
        key :operationId, 'showCity'
        key :tags, [
          'cities'
        ]

        parameter do
          key :'$ref', :city_id
        end

        response 200 do
          key :description, 'Successful response'
          content :'application/json' do
            schema do
              key :'$ref', :CityShowResponse
            end
          end
        end
      end
    end
  end
end
```
---
### Sample input
```ruby
# frozen_string_literal: true

module Inputs
  module City
    class CreateInput
      include Swagger::Blocks

      swagger_component do
        schema :CityCreateInput do
          key :required, %i[city]

          property :city do
            key :required, %i[name alpha_2_code]

            property :name do
              key :type, :string
              key :example, 'Ankara'
            end

            property :alpha_2_code do
              key :type, :string
              key :example, 'TR-06'
            end
          end
        end
      end
    end
  end
end
```
---
### Sample model
```ruby
# frozen_string_literal: true

module Models
  class City
    include Swagger::Blocks

    swagger_component do
      schema :City do
        key :type, :object
        key :required, %i[id name alpha_2_code]

        property :id do
          key :type, :string
          key :format, :uuid
          key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
        end

        property :name do
          key :type, :string
          key :example, 'Ankara'
        end

        property :alpha_2_code do
          key :type, :string
          key :example, 'TR-06'
        end
      end
    end
  end
end
```
---
### Sample parameter
```ruby
# frozen_string_literal: true

module Parameters
  class CityId
    include Swagger::Blocks

    swagger_component do
      parameter :city_id do
        key :name, :city_id
        key :in, :path
        key :description, 'The id of the city'
        key :required, true
        schema do
          key :type, :string
          key :format, :uuid
        end
      end
    end
  end
end
```
---
### Sample response
```ruby
# frozen_string_literal: true

module Responses
  module City
    class Show
      include Swagger::Blocks

      swagger_component do
        schema :CityShowResponse do
          key :type, :object
          key :required, %i[city meta]

          property :city do
            key :'$ref', :City
          end
        end
      end
    end
  end
end
```
