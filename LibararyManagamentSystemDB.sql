CREATE DATABASE LibraryManagementSystemDB
USE LibraryManagementSystemDB;

CREATE TABLE Members (
    MemberID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(20),
    MembershipStartDate DATE NOT NULL
);

CREATE TABLE Libraries (
    LibraryID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    ContactNumber NVARCHAR(20),
    EstablishedYear INT CHECK (EstablishedYear >= 1900)
);

CREATE TABLE Books (
        BookID INT PRIMARY KEY IDENTITY(1,1),
    ISBN NVARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(255) NOT NULL,
    Genre NVARCHAR(50) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    Price DECIMAL(10, 2) CHECK (Price > 0),
    IsAvailable BIT DEFAULT 1,
    ShelfLocation NVARCHAR(50),
    LibraryID INT NOT NULL,
    FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE Loans (
        LoanID INT PRIMARY KEY IDENTITY(1,1),
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status NVARCHAR(20) DEFAULT 'Issued' CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) CHECK (Amount > 0),
    PaymentMethod NVARCHAR(50) NOT NULL,
    LoanID INT NOT NULL,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Staffs (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    ContactNumber NVARCHAR(20),
    LibraryID INT NOT NULL,
    FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments NVARCHAR(255) DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE 
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
INSERT INTO Payments (loanID, PaymentDate, amount, PaymentMethod) VALUES
(2, '2025-05-10', 35.00, 'Credit Card'),
(3, '2025-05-24', 10.50, 'Cash');

-- Insert data into Staff
INSERT INTO Staffs (libraryID, fullName, position, contactNumber) VALUES
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
SELECT paymentID, loanID, PaymentDate, amount, PaymentMethod FROM Payments;

-- Select all staff members
SELECT staffID, libraryID, fullName, position, contactNumber FROM Staffs;

-- Select all reviews
SELECT reviewID, bookID, memberID, reviewDate, rating, comments FROM Reviews;
