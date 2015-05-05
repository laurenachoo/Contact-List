module ContactsApplication
    class Application
        def initialize contacts
            @contacts = contacts
        end
 
        def get_user_data message = ""
            self.message_putter message
            value = gets.chomp
            value
        end
 
        def instructions
            self.message_putter ["Welcome to the Contact List App, what would you like to do?",
                "To creat new contact, enter number 1",
                "To list all contacts, enter number 2",
                "To exit, enter number 3"]
        end
 
        def create
            values = {}
            [:name, :email, :phone].each do | field |
            values[field] = self.get_user_data "Enter with the #{field.to_s}"
            end
            @contacts.add_contact Contact.new(values)
        end
 
        def message_putter message
            message = [message] unless message.is_a? Array
            message.each { |m| puts m }
        end
 
        def list_all
            self.message_putter "List of contacts"
            @contacts.list_contacts do | c |
                puts c.printable_name
            end
        end
 
        def get_user_option
            self.get_user_data "Which function would you like to use next: Enter [1], [2], or [3]"
        end
 
        def handle_user_input input
            case input
            when "1"
                self.create
            when "2"
                self.list_all
            end
        end
 
        def start
            self.instructions
            until (input = self.get_user_option) == "3"
                self.handle_user_input input
            end
            self.message_putter "The App will now exit."
        end
    end
 
    class Contacts
        def initialize
            @contacts = []
        end
 
        def add_contact contact
            @contacts << contact
        end
 
        def list_contacts
            @contacts.each do | c |
                yield( c ) if block_given?
            end
        end   
    end
 
    class Contact
        attr_accessor :name, :email, :phone
        def initialize options = {}
            @name = options[:name]
            @email = options[:email]
            @phone = options[:phone]
        end
 
        def printable_name
            "#{@name} <#{@email}> - #{@phone}"
        end
    end
end
 
app = ContactsApplication::Application.new(ContactsApplication::Contacts.new)
app.start

  
      



