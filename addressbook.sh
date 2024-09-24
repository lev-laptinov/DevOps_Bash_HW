!/bin/bash

ADDRESS_BOOK="addressbook.txt"


add_contact() {
    echo "Adding a new contact..."
    read -p "Enter name: " name
    read -p "Enter phone number: " phone
    read -p "Enter email: " email

    echo "$name,$phone,$email" >> "$ADDRESS_BOOK"
    echo "Contact added successfully!"
}

search_contact() {
    read -p "Enter search term (name, phone, or email): " search_term
    
    results=$(grep -i "$search_term" "$ADDRESS_BOOK")
    
    if [ -z "$results" ]; then
        echo "No contacts found."
    else
        echo "Found contacts:"
        echo "$results" | while IFS=',' read -r name phone email; do
            echo "Name: $name, Phone: $phone, Email: $email"
        done
    fi
}

remove_contact() {
    read -p "Enter name, phone number, or email of the contact to remove: " identifier

    if grep -iq "$identifier" "$ADDRESS_BOOK"; then
        sed -i '' "/$identifier/d" "$ADDRESS_BOOK"
        echo "Contact removed."
    else
        echo "Contact not found."
    fi
}

case $1 in
    add)
        add_contact
        ;;
    search)
        search_contact
        ;;
    remove)
        remove_contact
        ;;
    *)
        echo "Invalid option. Use add, search or remove."
        exit 1
        ;;
esac
