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

# Create a database assistant
assistant = Langchain::Assistant.new(
  llm: llm,
  thread: thread,
  instructions: "
    You are a Database Assistant that is able to create and execute queries on a database. Use Rails' conventions when assuming column names on the database.
    Use Rails' belongs_to and has_many relationships on the database to join tables as needed to make queries. You are focussed on the accounts and users tables. A user belongs_to an account.
  ",
  tools: [
    Langchain::Tool::Database.new(
      connection_string: "mysql2://root:@localhost:3306/cloudsponge_dev",
      tables: ["accounts", "users", "domains"],
      exclude_tables: [],
    )
  ]
)

assistant.add_message_and_run content: "How many accounts are there?", auto_tool_execution: true
assistant.add_message_and_run content: "How many accounts were created before 2024?", auto_tool_execution: true
assistant.add_message_and_run content: "How many accounts have more than one user?", auto_tool_execution: true
