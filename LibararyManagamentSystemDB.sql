CREATE DATABASE LibraryManagementSystemDB
USE LibraryManagementSystemDB;
CREATE TABLE Members (
    memberID INT PRIMARY KEY IDENTITY,
    fullName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phoneNumber VARCHAR(15) NOT NULL,
    membershipStartDate DATE NOT NULL
);

CREATE TABLE Libraries (
    libraryID INT PRIMARY KEY IDENTITY,
    name nVARCHAR(100) NOT NULL,
    location nVARCHAR(100) NOT NULL,
    establishedYear int NOT NULL,
    contactNumber nVARCHAR(15) NOT NULL
);

CREATE TABLE Books (
    bookID INT PRIMARY KEY IDENTITY,
    ISBN VARCHAR(13) NOT NULL UNIQUE,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50) NOT NULL CHECK (genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    availabilityStatus BIT NOT NULL DEFAULT 1,
    shelfLocation VARCHAR(50) NOT NULL,
    libraryID INT NOT NULL,
    FOREIGN KEY (libraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE Loans (
    loanID INT PRIMARY KEY IDENTITY,
    memberID INT NOT NULL,
    bookID INT NOT NULL,
    loanDate DATE NOT NULL,
    dueDate DATE NOT NULL,
    returnDate DATE,
    status VARCHAR(10) NOT NULL CHECK (status IN ('Issued', 'Returned', 'Overdue')),
    FOREIGN KEY (memberID) REFERENCES Members(memberID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bookID) REFERENCES Books(bookID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Payments (
    paymentID INT PRIMARY KEY IDENTITY,
    loanID INT NOT NULL,
    transactionDate DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    method VARCHAR(50) NOT NULL,
    FOREIGN KEY (loanID) REFERENCES Loans(loanID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Staff (
    staffID INT PRIMARY KEY IDENTITY,
    libraryID INT NOT NULL,
    fullName VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    contactNumber VARCHAR(15) NOT NULL,
    FOREIGN KEY (libraryID) REFERENCES Libraries(libraryID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviews (
    reviewID INT PRIMARY KEY IDENTITY,
    bookID INT NOT NULL,
    memberID INT NOT NULL,
    reviewDate DATE NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comments TEXT DEFAULT 'No comments',
    FOREIGN KEY (bookID) REFERENCES Books(bookID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (memberID) REFERENCES Members(memberID) ON DELETE CASCADE ON UPDATE CASCADE
);




-- Insert data into Libraries
INSERT INTO Libraries (name, location, establishedYear, contactNumber) VALUES
('Central Library', '123 Main St', 1995, '123-456-7890'),
('Westside Library', '456 West Ave', 2005, '987-654-3210'),
('Eastside Library', '789 East Rd', 2010, '555-123-4567');

-- Insert data into Members
INSERT INTO Members (fullName, email, phoneNumber, membershipStartDate) VALUES
('John Doe', 'john@example.com', '111-222-3333', '2025-01-10'),
('Jane Smith', 'jane@example.com', '222-333-4444', '2025-02-15'),
('Alice Johnson', 'alice@example.com', '333-444-5555', '2025-03-20');

-- Insert data into Books
INSERT INTO Books (ISBN, title, genre, price, shelfLocation, libraryID) VALUES
('9783161484100', 'The Great Gatsby', 'Fiction', 15.99, 'A1', 1),
('9781234567897', 'Data Structures', 'Reference', 35.00, 'B2', 2),
('9781112223334', 'Children Stories', 'Children', 10.50, 'C3', 3);

-- Insert data into Loans
INSERT INTO Loans (memberID, bookID, loanDate, dueDate, status) VALUES
(1, 1, '2025-05-01', '2025-05-15', 'Issued'),
(2, 2, '2025-04-25', '2025-05-10', 'Returned'),
(3, 3, '2025-05-10', '2025-05-24', 'Overdue');

-- Insert data into Payments
INSERT INTO Payments (loanID, transactionDate, amount, method) VALUES
(2, '2025-05-10', 35.00, 'Credit Card'),
(3, '2025-05-24', 10.50, 'Cash');

-- Insert data into Staff
INSERT INTO Staff (libraryID, fullName, position, contactNumber) VALUES
(1, 'Michael Brown', 'Librarian', '555-666-7777'),
(2, 'Sara White', 'Assistant Librarian', '555-888-9999');

-- Insert data into Reviews
INSERT INTO Reviews (bookID, memberID, reviewDate, rating, comments) VALUES
(1, 1, '2025-05-05', 4, 'Great read!'),
(2, 2, '2025-05-12', 5, 'Very informative.'),
(3, 3, '2025-05-14', 3, 'Good for kids.');


-- Select all members
SELECT * FROM Members;

-- Select all books
SELECT bookID, title, genre, price, shelfLocation, libraryID FROM Books;

-- Select all loans
SELECT loanID, memberID, bookID, loanDate, dueDate, status FROM Loans;

-- Select all payments
SELECT paymentID, loanID, transactionDate, amount, method FROM Payments;

-- Select all staff members
SELECT staffID, libraryID, fullName, position, contactNumber FROM Staff;

-- Select all reviews
SELECT reviewID, bookID, memberID, reviewDate, rating, comments FROM Reviews;
