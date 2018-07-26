AUTHORS = ['Bill Bryson', 'Conn Iggulden', 'Mary Berry', 'Lesley Pearse', 'Zadie Smith', 'Dan Brown']
CATEGORIES = ['Science Fiction', 'Detectives', 'Satire', 'Drama', 'Horror']
BOOKS = [
    'In Search of Lost Time by Marcel Proust',
    'Don Quixote by Miguel de Cervantes',
    'Ulysses by James Joyce',
    'The Great Gatsby by F. Scott Fitzgerald',
    'Moby Dick by Herman Melville',
    'Hamlet by William Shakespeare',
    'War and Peace by Leo Tolstoy',
    'The Odyssey by Homer',
    'The Divine Comedy by Dante Alighieri'
]


User.create(email: 'user@example.com', nickname: 'test', name: 'Ivan Pupkov', password: "pupkov66") unless User.find_by_email('user@example.com')

AUTHORS.each do |name|
    Author.create(name: name) unless Author.find_by_name(name)
end

CATEGORIES.each do |name| 
    Category.create(name: name) unless Category.find_by_name(name)
end 

BOOKS.each do |title| 
    Book.create(title: title) unless Book.find_by_title(title)
end 