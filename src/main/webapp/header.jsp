<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 02/10/2024
  Time: 12:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="bg-gray-500 sticky top-0 z-50 px-4">
    <div class="container mx-auto flex justify-between items-center py-4">
        <!-- Left section: Logo -->
        <div class="flex items-center">
            <img src="https://spacema-dev.com/blue-star/assets/images/blue-logo.png" alt="Logo" class="h-14 w-auto mr-4">
        </div>

        <!-- Hamburger menu (for mobile) -->
        <div class="flex md:hidden">
            <button id="hamburger" class="text-white focus:outline-none">
                <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path>
                </svg>
            </button>
        </div>

        <!-- Center section: Menu -->
        <nav class="hidden md:flex md:flex-grow justify-center">
            <ul class="flex justify-center space-x-4 text-white">
                <li><a href="#home" class="hover:text-secondary font-bold">Home</a></li>
                <li><a href="#aboutus" class="hover:text-secondary font-bold">About us</a></li>
                <li><a href="#results" class="hover:text-secondary font-bold">Results</a></li>
                <li><a href="#reviews" class="hover:text-secondary font-bold">Reviews</a></li>
                <li><a href="#portfolio" class="hover:text-secondary font-bold">Portfolio</a></li>
                <li><a href="#team" class="hover:text-secondary font-bold">Team</a></li>
                <li><a href="#contact" class="hover:text-secondary font-bold">Contact</a></li>
            </ul>
        </nav>

        <!-- Right section: Buttons (for desktop) -->
        <div class="hidden lg:flex items-center space-x-4">
            <a href="#" class="bg-green-500 hover:bg-blue-500 text-white font-semibold px-4 py-2 rounded inline-block">Github</a>
            <a href="#" class="bg-blue-500 hover:bg-green-500 text-white font-semibold px-4 py-2 rounded inline-block">Download</a>
        </div>
    </div>
</header>

<!-- Mobile menu -->
<nav id="mobile-menu-placeholder" class="mobile-menu hidden flex-col items-center space-y-8 md:hidden px-8">
    <ul class="w-full text-center">
        <li class="border-b border-gray-300 pb-4 pt-4"><a href="#home" class="hover:text-secondary font-bold">Home</a></li>
        <li class="border-b border-gray-300 pb-4 pt-4"><a href="#aboutus" class="hover:text-secondary font-bold">About us</a></li>
        <li class="border-b border-gray-300 pb-4 pt-4"><a href="#results" class="hover:text-secondary font-bold">Results</a></li>
        <li class="border-b border-gray-300 pb-4 pt-4"><a href="#reviews" class="hover:text-secondary font-bold">Reviews</a></li>
        <li class="border-b border-gray-300 pb-4 pt-4"><a href="#portfolio" class="hover:text-secondary font-bold">Portfolio</a></li>
        <li class="border-b border-gray-300 pb-4 pt-4"><a href="#team" class="hover:text-secondary font-bold">Team</a></li>
        <li class="pb-4 pt-4"><a href="#contact" class="hover:text-secondary font-bold">Contact</a></li>
    </ul>
    <div class="flex flex-col mt-6 space-y-2 items-center">
        <a href="#" class="bg-green-500 hover:bg-blue-500 text-white font-semibold px-4 py-2 rounded inline-block flex items-center justify-center min-w-[110px]">Github</a>
        <a href="#" class="bg-blue-500 hover:bg-green-500 text-white font-semibold px-4 py-2 rounded inline-block flex items-center justify-center min-w-[110px]">Download</a>
    </div>
</nav>
