# Rate Limiter in Ruby (Sliding Window)

This project implements a **Rate Limiter** in Ruby using the **sliding window algorithm**, designed to efficiently handle API requests for millions of users.

## Usage

1. Clone the repository:

```bash
git clone git@github.com:jwaldimer/rate-limiter.git
cd rate-limiter
```

2. Run the tests:

```bash
gem install rspec
rspec spec/rate_limiter_spec.rb
```

## Example

To run an example:

```ruby
ruby stream_runner.rb 
```

## Tests Covered

- Allows requests within limit
- Blocks requests over the limit
- Automatically expires old requests after the window
- Handles multiple users independently


## Author

Developed by [Jorge Gómez](https://github.com/jwaldimer) as part of a technical assessment.

## 📝 License

MIT — feel free to use and modify.
