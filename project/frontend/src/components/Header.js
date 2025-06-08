import React from 'react';

function Header() {
  return (
    <header>
      <div className="navbar">
        <div className="logo">
          <img src="/images/logo.png" alt="Fresh Coconut Logo" />
        </div>
        <nav>
          <ul>
            <li><a href="#about">About</a></li>
            <li><a href="#order">Order Now</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </nav>
      </div>
    </header>
  );
}

export default Header;
