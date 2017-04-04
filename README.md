# Speechmatex

[![Build Status](https://travis-ci.org/findmypast-oss/speechmatex.svg?branch=master)](https://travis-ci.org/findmypast-oss/speechmatex)
[![Coverage Status](https://coveralls.io/repos/github/findmypast-oss/speechmatex/badge.svg?branch=master)](https://coveralls.io/github/findmypast-oss/speechmatex?branch=master)

**Speechmatics API Client written in Elixir**

[Speechmatics API Documentation](https://app.speechmatics.com/api-details)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `speechmatex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:speechmatex, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/speechmatex](https://hexdocs.pm/speechmatex).

## Example Usage

### Account

#### Get Account Details

```elixir
iex> Speechmatex.Account.details()
{:ok, %{"balance" => 1920, "email" => "mr_test@testerson.com", "id" => 43641}}
```

### Job

#### Send for transcription

Send an audio file off for transcription.

```elixir
iex> Speechmatex.Job.send_for_transcription("/home/developer/Downloads/example.mp3", "en-GB")

{:ok, %{"balance" => 1964, "check_wait" => 30, "cost" => 8, "id" => 2293106}}
```

#### Get transcription

Get the transcription of a completed job.

```elixir
iex> Speechmatex.Job.get_transcription(2293106)

{:ok,
 %{"format" => "1.0",
   "job" => %{"created_at" => "Tue Apr  4 13:25:57 2017", "duration" => 79,
     "id" => 2293106, "lang" => "en-GB", "name" => "DASD.mp3",
     "user_id" => 19057},
   "speakers" => [%{"confidence" => nil, "duration" => "22.150000",
      "name" => "F2", "time" => "12.250000"},
    %{"confidence" => nil, "duration" => "10.010000", "name" => "F3",
      "time" => "34.400000"},
    %{"confidence" => nil, "duration" => "23.820000", "name" => "F2",
      "time" => "44.410000"},
    %{"confidence" => nil, "duration" => "9.820000", "name" => "F3",
      "time" => "68.230000"}],
   "words" => [%{"confidence" => "0.610", "duration" => "0.220000",
      "name" => "It's", "time" => "12.250000"},
    %{"confidence" => "0.610", "duration" => "0.380000", "name" => "exciting",
      "time" => "12.510000"},
    %{"confidence" => "0.800", "duration" => "0.330000", "name" => ".",
      "time" => "13.000000"},
    %{"confidence" => "0.320", "duration" => "0.140000", "name" => "I'm",
      "time" => "13.450000"},
    %{"confidence" => "0.310", "duration" => "0.170000", "name" => "a",
      "time" => "13.630000"},
    %{"confidence" => "1.000", "duration" => "0.060000", "name" => "you",
      "time" => "13.940000"},
    %{"confidence" => "1.000", "duration" => "0.170000", "name" => "know",
      "time" => "14.390000"}]}}
```

## License

Copyright © 2017 Findmypast

Distributed under the Apache License 2.0
