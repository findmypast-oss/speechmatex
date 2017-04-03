# Speechmatex

[![Build Status](https://travis-ci.org/findmypast-oss/speechmatex.svg?branch=master)](https://travis-ci.org/findmypast-oss/speechmatex)

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

## Usage

#### Service Status

```elixir
iex> Speechmatex.service_status()
{:ok,
 %{Average_Turnaround_Mins: 0, Known_Issues: false, Queue_Length_Mins: 0,
   Status: "Good", Time_UTC: "Mon, 03 Apr 2017 15:20:02 GMT"}}
```

### Account

#### Get Account Details

```elixir
iex> Speechmatex.Account.details()
{:ok, %{balance: 1920, email: "mr_test@testerson.com", id: 43641}}
```

#### Get Payments History

This is a list of both payments and debits made for transcriptions.

```elixir
iex> Speechmatex.Account.payments()
{:ok,
 [%{balance: -6, created_at: "Fri, 31 Mar 2017 08:54:25 GMT",
    description: "transcription_0001.m4a"},
  %{balance: 360, created_at: "Tue, 21 Mar 2017 09:56:50 GMT",
     description: "60 free minutes of transcription on registration"}]
```

### Job
