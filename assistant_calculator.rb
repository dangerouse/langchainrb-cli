# Not intended to be executed.
# These are just some notes for initializing the environment at the command line. It's not very useful to run this file directly.
require "dotenv"
require "langchain"
Dotenv.load('.env.local')

Langchain.logger.level = :debug
llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

# Instantiate a Thread. Threads keep track of the messages in the Assistant conversation.
thread = Langchain::Thread.new

# You can pass old message from previously using the Assistant:
# thread.messages = messages

# Instantiate an Assistant
assistant = Langchain::Assistant.new(
  llm: llm,
  thread: thread,
  instructions: "You are a Calculator Assistant that is able to do any math required",
  tools: [
    Langchain::Tool::Calculator.new
  ]
)

assistant.add_message content: "What is 2 + 2?"
assistant.add_message content: "What is the square root of 4?"
assistant.add_message content: "What is the square root of 16?"
assistant.run
assistant.run(auto_tool_execution: true)

assistant.add_message_and_run content: "What is natural log of (52 - 24 + 18)^2?", auto_tool_execution: true

# Create a database assistant
assistant = Langchain::Assistant.new(
  llm: llm,
  thread: thread,
  instructions: "You are a Database Assistant that is able to create and execute queries on a database.",
  tools: [
    Langchain::Tool::Database.new(
      connection_string: "mysql2://root:@localhost:3306/cloudsponge_dev",
      tables: [],
      exclude_tables: [],
    )
  ]
)
