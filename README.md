# Langchainrb CLI

Test out langchainrb using the command line only.

Create the Gemfile

    bundle init

Before langchainrb would install, I needed to config this flag for compilation on my Apple silicon:

    bundle config build.unicode -- --with-cflags="-Wno-incompatible-function-pointer-types"

Then I could add the gem:

    bundle add langchainrb

And I added the OpenAI integration:

    bundle add ruby-openai

I am storing my keys in .env.local and loading them using dotenv:

    bundle add dotenv

OK, now I can start the CLI with bundle:

    bundle exec irb
