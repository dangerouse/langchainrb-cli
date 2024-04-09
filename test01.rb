# Not intended to be executed.
# These are just some notes for initializing the environment at the command line. It's not very useful to run this file directly.
require "dotenv"
require "langchain"
Dotenv.load('.env.local')

llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

# embed text as a vector
llm.embed(text: "foo bar").embedding

# send a prompt to be completed
llm.chat(messages: [{role:"user", content: "write my cover letter for a job interview with a milk delivery company. I am interviewing for the job of a milkman. "}]).completion
