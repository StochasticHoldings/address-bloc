require_relative '../models/address_book'

RSpec.describe AddressBook do
  def check_entry(entry, expected_name, expected_number, expected_email)
     expect(entry.name).to eq expected_name
     expect(entry.phone_number).to eq expected_number
     expect(entry.email).to eq expected_email
   end
  context 'attributes' do
    let(:book) {AddressBook.new}



    it "should respond to entries" do
      expect(book).to respond_to(:entries)
    end
  end

  context 'initialized Address book' do
    let(:book) {AddressBook.new}

    it "entries should be an array" do
      expect(book.entries.class).to eq(Array)
    end

    it "entries should be empty" do
      expect(book.entries.empty?).to eq(true)
    end
  end

  context '#add_entry' do
    let(:book) {AddressBook.new}
    let(:entry) {Entry.new("colby", "555-555-1212", "email@gmail.com")}
    let (:entry1) {Entry.new("a", "555-1212", "email")}
    let (:entry2) {Entry.new("b", "555-1212", "email")}
    let (:entry3) {Entry.new("c", "555-1212", "email")}


    it "should add an entry" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expect(book.entries.size).to eq(1)
    end

    it "should not accept duplicates" do
      book.add_entry("a", "555-1212", "email")
      book.add_entry("a","555-1212","email")
      expect(book.entries.size).to eq(1)
    end

    it "should be in alphabetical order" do
      book.add_entry("c", "555-1212", "email")
      book.add_entry("a", "555-1212", "email")
      book.add_entry("b", "555-1212", "email")
      expect(book.entries.index(entry2)).to eq(1)
    end

    describe "#import_from_csv" do
      it "imports the correct number of entries" do

        book.import_from_csv("entries.csv")
        book_size = book.entries.size

        expect(book_size).to eq 5
      end

      it "imports the 1st entry" do
        book.import_from_csv("entries.csv")

        entry_one = book.entries[0]

        check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
      end

      it "imports the 2nd entry" do
        book.import_from_csv("entries.csv")

        entry_two = book.entries[1]

        check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
      end

      it "imports the 3rd entry" do
        book.import_from_csv("entries.csv")

        entry_three = book.entries[2]

        check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
      end

      it "imports the 4th entry" do
        book.import_from_csv("entries.csv")

        entry_four = book.entries[3]

        check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
      end

      it "imports the 5th entry" do
        book.import_from_csv("entries.csv")

        entry_five = book.entries[4]

        check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
      end
    end
  end
end
