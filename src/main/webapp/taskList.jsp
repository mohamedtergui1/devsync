<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Task" %>
<%@ page import="org.example.entity.Tag" %>
<%@ page import="org.example.entity.User" %>
<%@ page import="org.example.enums.UserRole" %>
<%@ page import="org.example.enums.TaskStatus" %>
<%@ page import="java.util.stream.Collectors" %>


<%
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    List<User> users = (List<User>) request.getAttribute("users");
    List<Tag> tags = (List<Tag>) request.getAttribute("tags");
    User authenticatedUser = (User) request.getSession().getAttribute("authenticatedUser");
%>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) { %>
<div id="alert-2"
     class="flex items-center p-4 mb-4 text-red-800 rounded-lg bg-red-50 dark:bg-gray-800 dark:text-red-400"
     role="alert">
    <!-- Icon -->
    <svg class="flex-shrink-0 w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor"
         viewBox="0 0 20 20">
        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"/>
    </svg>

    <!-- Screen reader text -->
    <span class="sr-only">Error</span>

    <!-- Error Message -->
    <div class="ms-3 text-sm font-medium">
        <%= error %>
    </div>

    <!-- Close Button -->
    <button type="button"
            class="ms-auto -mx-1.5 -my-1.5 bg-red-50 text-red-500 rounded-lg focus:ring-2 focus:ring-red-400 p-1.5 hover:bg-red-200 inline-flex items-center justify-center h-8 w-8 dark:bg-gray-800 dark:text-red-400 dark:hover:bg-gray-700"
            onclick="document.getElementById('alert-2').style.display='none';" aria-label="Close">
        <span class="sr-only">Close</span>
        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
        </svg>
    </button>
</div>
<% } %>


<div id="createProductModal" tabindex="-1" aria-hidden="true"
     class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
    <div class="relative p-4 w-full max-w-2xl max-h-full">
        <!-- Modal content -->
        <div class="relative p-4 bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
            <!-- Modal header -->
            <div class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5 dark:border-gray-600">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Add Task</h3>
                <button type="button"
                        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                        data-modal-target="createProductModal" data-modal-toggle="createProductModal">
                    <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                         xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"/>
                    </svg>
                    <span class="sr-only">Close modal</span>
                </button>
            </div>
            <!-- Modal body -->
            <form action="" method="post">
                <div class="grid gap-4 mb-4 sm:grid-cols-2">

                    <div>
                        <label for="title" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            title</label>
                        <input type="text" name="title" value="" id="title"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               placeholder="Ex. Apple iMac 27&ldquo;">
                    </div>
                    <div>
                        <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            description</label>
                        <input type="text" name="description" id="description"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               placeholder="Ex. Apple iMac 27&ldquo;">
                    </div>
                    <div>
                        <label for="due_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            due date</label>
                        <input type="datetime-local" name="due_date" id="due_date"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               placeholder="Ex. Apple iMac 27&ldquo;">
                    </div>

                    <%
                        if (authenticatedUser != null && authenticatedUser.getRole() == UserRole.MANAGER) {
                    %>
                    <div class="max-w-sm mx-auto">
                        <label for="countriess" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Assigned
                            to</label>
                        <select id="countriess" name="assigned_to"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                            <%
                                for (User user : users) {
                                    if (authenticatedUser != null && authenticatedUser.getId() == user.getId())
                                        continue;
                            %>
                            <option value="<%= user.getId() %>"><%= user.getUsername() %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <%
                        }
                    %>


                    <div class="max-w-sm w-24 mx-auto">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">tags </label>

                        <select
                                id="selectTag"
                                name="tags[]"
                                multiple
                                placeholder="Select roles..."
                                autocomplete="off"
                                class="block selectTag w-full rounded-sm cursor-pointer focus:outline-none"
                                multiple
                        >
                            <%
                                for (Tag tag : tags) {
                            %>
                            <option value="<%=tag.getId()%>"><%=tag.getName()%>
                            </option>
                            <% } %>
                        </select>
                    </div>

                </div>
                <div class="flex items-center space-x-4">
                    <button type="submit"
                            class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Update Task
                    </button>
                    <button type="button"
                            class="text-red-600 inline-flex items-center hover:text-white border border-red-600 hover:bg-red-600 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                        <svg class="mr-1 -ml-1 w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                             xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                  d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                  clip-rule="evenodd"></path>
                        </svg>
                        Delete
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<div style="width: 100vw" class="bg-gray-100 min-h-screen p-8">
    <div class="container mx-auto">
        <h1 class="text-3xl font-bold text-center mb-8">Kanban Board</h1>

        <div class="flex flex-col md:flex-row gap-6">

            <div class="flex-1 bg-gray-200 p-4 rounded-lg shadow">
                <h2 class="text-xl font-semibold mb-4">In Progress</h2>
                <% for (Task task : tasks.stream().filter((e) -> e.getStatus() == TaskStatus.PENDING).collect(Collectors.toList())) { %>

                <ul id="todo-list" class="min-h-[200px] my-2 bg-gray-300 rounded-lg  space-y-2">
                    <div class="flex justify-end gap-5 ">
                        <% if (authenticatedUser.getRole() == UserRole.MANAGER && task.getRequest() != null && task.getRequest().getStatus() == 'P') { %>
                        <li class="flex justify-around">


                            <button data-modal-target="progress-modal<%=task.getId()%>"
                                    data-modal-toggle="progress-modal<%=task.getId()%>" type="button"
                                    class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                assign it to another
                            </button>
                            <form action="request" method="post">
                                <input name="_method" value="reject" type="hidden"/>
                                <input name="id" value="<%=task.getRequest().getId()%>" type="hidden"/>
                                <button
                                        class="text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 focus:outline-none dark:focus:ring-red-800">
                                    reject
                                </button>
                            </form>


                            <div id="progress-modal<%=task.getId()%>" tabindex="-1" aria-hidden="true"
                                 class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                                <div class="relative p-4 w-full max-w-md max-h-full">
                                    <!-- Modal content -->
                                    <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                        <button type="button"
                                                class="absolute top-3 mb-24 end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                                data-modal-hide="progress-modal<%=task.getId()%>">
                                            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                                 fill="none" viewBox="0 0 14 14">
                                                <path stroke="currentColor" stroke-linecap="round"
                                                      stroke-linejoin="round" stroke-width="2"
                                                      d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                            </svg>
                                            <span class="sr-only">Close modal</span>
                                        </button>

                                        <form method="post" action="request" class="max-w-sm  mx-auto">
                                            <div class="py-4">
                                                <input name="_method" value="accept" type="hidden"/>
                                                <input name="id" value="<%=task.getRequest().getId()%>" type="hidden"/>
                                            </div>
                                            <label for="a"
                                                   class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select
                                                an option</label>
                                            <select id="a" name="newAssign"
                                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                                <option selected disabled>Choose another user</option>
                                                <% for (User user : users) {
                                                    if (user.getId() != task.getAssignedTo().getId() && user.getRole() != UserRole.MANAGER) { %>
                                                <option value="<%=user.getId()%>"><%=user.getUsername()%>
                                                </option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                            <div class="p-4 md:p-5">
                                                <div class="flex items-center mt-6 space-x-4 rtl:space-x-reverse">
                                                    <button
                                                            class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                                        update
                                                    </button>
                                                    <button data-modal-hide="progress-modal<%=task.getId()%>"
                                                            type="button"
                                                            class="py-2.5 px-5 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">
                                                        Cancel
                                                    </button>
                                                </div>
                                            </div>
                                        </form>


                                    </div>
                                </div>
                            </div>

                        </li>
                        <%}%>
                        <% if (task.getRequest() == null && authenticatedUser.getToken().getUpdateTokenCount() > 0 && authenticatedUser.getRole() != UserRole.MANAGER) { %>
                        <li>
                            <form action="request" method="post">
                                <input name="id" value="<%= task.getId() %>" type="hidden"/>
                                <button
                                        class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                                    <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 20 20"
                                         fill="currentColor" aria-hidden="true">
                                        <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"/>
                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                              d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"/>
                                    </svg>
                                    Request To Change
                                </button>
                            </form>
                        </li>
                        <% } else if (task.getRequest() != null && task.getRequest().getStatus() == 'P' && task.getAssignedTo().getId() == authenticatedUser.getId()) {%>

                        <span class="px-2 py-1">
                                    request pending
                                </span>

                        <%} else if (task.getRequest() != null && task.getRequest().getStatus() == 'R') { %>

                        <span class="px-2 py-1">rejected</span>

                        <%}%>
                        <% if (task.getAssignedTo().getId() == authenticatedUser.getId()) { %>
                        <li>
                            <form method="post">
                                <input type="hidden" name="id" value="<%=task.getId()%>">
                                <input type="hidden" name="_method" value="done">

                                <button class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                                    <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 20 20"
                                         fill="currentColor" aria-hidden="true">
                                        <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"/>
                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                              d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"/>
                                    </svg>
                                    make it done
                                </button>
                            </form>
                        </li>
                        <% } %>

                        <% if (authenticatedUser.getRole() == UserRole.MANAGER || task.getCreatedBy().getId() == authenticatedUser.getId()) { %>


                        <li>
                            <button type="button" data-modal-target="<%= task.getId() %>"
                                    data-modal-toggle="<%= task.getId() %>"
                                    class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                                <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 20 20"
                                     fill="currentColor" aria-hidden="true">
                                    <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"/>
                                    <path fill-rule="evenodd" clip-rule="evenodd"
                                          d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"/>
                                </svg>
                                Edit
                            </button>

                            <div id="<%= task.getId() %>" tabindex="-1" aria-hidden="true"
                                 class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                                <div class="relative p-4 w-full max-w-2xl max-h-full">
                                    <!-- Modal content -->
                                    <div class="relative p-4 bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
                                        <!-- Modal header -->
                                        <div class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5 dark:border-gray-600">
                                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Update
                                                Product</h3>
                                            <button type="button"
                                                    class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                                    data-modal-toggle="<%= task.getId() %>">
                                                <svg aria-hidden="true" class="w-5 h-5" fill="currentColor"
                                                     viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd"
                                                          d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                          clip-rule="evenodd"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <!-- Modal body -->
                                        <form action="" method="post">
                                            <div class="grid gap-4 mb-4 sm:grid-cols-2">
                                                <input name="_method" type="hidden" value="put"/>
                                                <input name="id" value="<%=task.getId()%>" type="hidden"/>
                                                <div>
                                                    <label for="title<%=task.getId()%>"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        title</label>
                                                    <input type="text" name="title" value="<%=task.getTitle()%>"
                                                           id="title<%=task.getId()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="Ex. Apple iMac 27&ldquo;">
                                                </div>
                                                <div>
                                                    <label for="description"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        name</label>
                                                    <input type="text" name="description"
                                                           value="<%=task.getDescription()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="">
                                                </div>
                                                <div>
                                                    <label for="due_date"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        name</label>
                                                    <input type="datetime-local" name="due_date"
                                                           value="<%=task.getDueDate()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="">
                                                </div>

                                                <%
                                                    if (authenticatedUser != null && authenticatedUser.getRole() == UserRole.MANAGER) {
                                                %>
                                                <div class="max-w-sm mx-auto">
                                                    <label for="countries"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Assigned
                                                        to</label>
                                                    <select id="countries" name="assigned_to"
                                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                                        <%
                                                            for (User user : users) {
                                                                if (authenticatedUser.getId() == user.getId())
                                                                    continue;
                                                        %>
                                                        <option value="<%= user.getId() %>"  <%= user.getId() == task.getAssignedTo().getId() ? "selected" : "" %> ><%= user.getUsername() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <%
                                                    }
                                                %>


                                                <div class="max-w-sm w-24 mx-auto">
                                                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">tags </label>

                                                    <select
                                                            id="selectTag<%=task.getId()%>"
                                                            name="tags[]"
                                                            multiple
                                                            placeholder="Select roles..."
                                                            autocomplete="off"
                                                            class="block w-full rounded-sm cursor-pointer focus:outline-none"
                                                    >
                                                        <%
                                                            for (Tag tag : tags) {
                                                        %>
                                                        <option value="<%= tag.getId() %>" <%= task.getTags().stream().filter(a -> a.getId() == tag.getId()).collect(Collectors.toList()).isEmpty() ? "" : "selected" %>><%= tag.getName() %>
                                                        </option>

                                                        <%
                                                            }
                                                        %>
                                                    </select>

                                                </div>

                                            </div>
                                            <div class="flex items-center space-x-4">
                                                <button type="submit"
                                                        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                                    Update Task
                                                </button>
                                                <button type="button"
                                                        class="text-red-600 inline-flex items-center hover:text-white border border-red-600 hover:bg-red-600 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                                                    <svg class="mr-1 -ml-1 w-5 h-5" fill="currentColor"
                                                         viewbox="0 0 20 20"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd"
                                                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                                              clip-rule="evenodd"></path>
                                                    </svg>
                                                    Delete
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <script>
                                $(document).ready(function () {
                                    $('#selectTag<%=task.getId()%>').select2();
                                });
                            </script>


                        </li>
                        <% } %>
                        <% if (authenticatedUser.getRole() == UserRole.MANAGER || authenticatedUser.getToken().getDeletionTokenCount() > 0 || task.getCreatedBy().getId() == authenticatedUser.getId()) { %>
                        <li>
                            <button type="button" data-modal-target="deleteModal<%=task.getId()%>"
                                    data-modal-toggle="deleteModal<%=task.getId()%>"
                                    class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 text-red-500 dark:hover:text-red-400">
                                <svg class="w-4 h-4 mr-2" viewbox="0 0 14 15" fill="none"
                                     xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path fill-rule="evenodd" clip-rule="evenodd" fill="currentColor"
                                          d="M6.09922 0.300781C5.93212 0.30087 5.76835 0.347476 5.62625 0.435378C5.48414 0.523281 5.36931 0.649009 5.29462 0.798481L4.64302 2.10078H1.59922C1.36052 2.10078 1.13161 2.1956 0.962823 2.36439C0.79404 2.53317 0.699219 2.76209 0.699219 3.00078C0.699219 3.23948 0.79404 3.46839 0.962823 3.63718C1.13161 3.80596 1.36052 3.90078 1.59922 3.90078V12.9008C1.59922 13.3782 1.78886 13.836 2.12643 14.1736C2.46399 14.5111 2.92183 14.7008 3.39922 14.7008H10.5992C11.0766 14.7008 11.5344 14.5111 11.872 14.1736C12.2096 13.836 12.3992 13.3782 12.3992 12.9008V3.90078C12.6379 3.90078 12.8668 3.80596 13.0356 3.63718C13.2044 3.46839 13.2992 3.23948 13.2992 3.00078C13.2992 2.76209 13.2044 2.53317 13.0356 2.36439C12.8668 2.1956 12.6379 2.10078 12.3992 2.10078H9.35542L8.70382 0.798481C8.62913 0.649009 8.5143 0.523281 8.37219 0.435378C8.23009 0.347476 8.06631 0.30087 7.89922 0.300781H6.09922ZM4.29922 5.70078C4.29922 5.46209 4.39404 5.23317 4.56282 5.06439C4.73161 4.8956 4.96052 4.80078 5.19922 4.80078C5.43791 4.80078 5.66683 4.8956 5.83561 5.06439C6.0044 5.23317 6.09922 5.46209 6.09922 5.70078V11.1008C6.09922 11.3395 6.0044 11.5684 5.83561 11.7372C5.66683 11.906 5.43791 12.0008 5.19922 12.0008C4.96052 12.0008 4.73161 11.906 4.56282 11.7372C4.39404 11.5684 4.29922 11.3395 4.29922 11.1008V5.70078ZM8.79922 4.80078C8.56052 4.80078 8.33161 4.8956 8.16282 5.06439C7.99404 5.23317 7.89922 5.46209 7.89922 5.70078V11.1008C7.89922 11.3395 7.99404 11.5684 8.16282 11.7372C8.33161 11.906 8.56052 12.0008 8.79922 12.0008C9.03791 12.0008 9.26683 11.906 9.43561 11.7372C9.6044 11.5684 9.69922 11.3395 9.69922 11.1008V5.70078C9.69922 5.46209 9.6044 5.23317 9.43561 5.06439C9.26683 4.8956 9.03791 4.80078 8.79922 4.80078Z"/>
                                </svg>
                                Delete
                            </button>
                        </li>

                        <div id="deleteModal<%=task.getId()%>" tabindex="-1" aria-hidden="true"
                             class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                            <div class="relative p-4 w-full max-w-md max-h-full">
                                <!-- Modal content -->
                                <div class="relative p-4 text-center bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
                                    <button type="button"
                                            class="text-gray-400 absolute top-2.5 right-2.5 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                            data-modal-toggle="deleteModal<%=task.getId()%>">
                                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd"
                                                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                  clip-rule="evenodd"/>
                                        </svg>
                                        <span class="sr-only">Close modal</span>
                                    </button>
                                    <svg class="text-gray-400 dark:text-gray-500 w-11 h-11 mb-3.5 mx-auto"
                                         aria-hidden="true" fill="currentColor" viewbox="0 0 20 20"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd"
                                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                              clip-rule="evenodd"/>
                                    </svg>
                                    <p class="mb-4 text-gray-500 dark:text-gray-300">Are you sure you want to delete
                                        this item?</p>
                                    <form class="flex justify-center items-center space-x-4" method="post">
                                        <input type="hidden" name="_method" value="delete">
                                        <input type="hidden" name="id" value="<%= task.getId() %>"/>
                                        <button type="button"
                                                class="py-2 px-3 text-sm font-medium text-gray-500 bg-white rounded-lg border border-gray-200 hover:bg-gray-100 focus:ring-4 focus:outline-none"
                                                onclick="closeModal('deleteModal<%= task.getId() %>')">No, cancel
                                        </button>
                                        <button type="submit"
                                                class="py-2 px-3 text-sm font-medium text-center text-white bg-red-600 rounded-lg hover:bg-red-700 focus:ring-4 focus:outline-none">
                                            Yes, I'm sure
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="px-4 py-4 mx-5 font-normal bg-gray-300 rounded-lg my-2 ">
                        <div class="flex flex-col justify-between md:flex-row">
                            <h3 class="mb-2 text-2xl font-semibold leading-snug">
                                <%=task.getTitle()%>
                            </h3>
                            <div class="flex items-center mb-2 space-x-2">
                                <% for (Tag tag : task.getTags()) { %>
                                <p class="px-2 text-gray-200 bg-blue-600 rounded"><%=tag.getName()%>
                                </p>
                                <% } %>
                            </div>
                        </div>
                        <p class="text-gray-700">
                            <%= task.getDescription()%>
                        </p>
                        <h2><%=task.getAssignedTo() != null ? task.getAssignedTo().getUsername() : "no one"%>
                        </h2>
                        <h2><%=task.getCreatedBy() != null ? task.getCreatedBy().getUsername() : "no one"%>
                        </h2>
                        <p><%=task.getDueDate()%>
                        </p>

                    </div>
                </ul>

                <% } %>
                <button type="button" id="createProductModalButton" data-modal-target="createProductModal"
                        data-modal-toggle="createProductModal"
                        class="mt-4 w-full bg-teal-500 text-white py-2 px-4 rounded hover:bg-teal-600 transition duration-300">
                    Add Task
                </button>
            </div>


            <div class="flex-1 bg-gray-200 p-4 rounded-lg shadow">
                <h2 class="text-xl font-semibold mb-4">Done</h2>
                <% for (Task task : tasks.stream().filter((e) -> e.getStatus() == TaskStatus.COMPLETED).collect(Collectors.toList())) { %>

                <ul id="todo-list" class="min-h-[200px] my-2 bg-green-300 rounded-lg  space-y-2">
                    <div class="flex justify-end gap-5 ">

                        <% if (authenticatedUser.getRole() == UserRole.MANAGER || task.getCreatedBy().getId() == authenticatedUser.getId()) { %>


                        <li>
                            <button type="button" data-modal-target="<%= task.getId() %>"
                                    data-modal-toggle="<%= task.getId() %>"
                                    class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                                <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 20 20"
                                     fill="currentColor" aria-hidden="true">
                                    <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"/>
                                    <path fill-rule="evenodd" clip-rule="evenodd"
                                          d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"/>
                                </svg>
                                Edit
                            </button>

                            <div id="<%= task.getId() %>" tabindex="-1" aria-hidden="true"
                                 class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                                <div class="relative p-4 w-full max-w-2xl max-h-full">
                                    <!-- Modal content -->
                                    <div class="relative p-4 bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
                                        <!-- Modal header -->
                                        <div class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5 dark:border-gray-600">
                                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Update
                                                Product</h3>
                                            <button type="button"
                                                    class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                                    data-modal-toggle="<%= task.getId() %>">
                                                <svg aria-hidden="true" class="w-5 h-5" fill="currentColor"
                                                     viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd"
                                                          d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                          clip-rule="evenodd"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <!-- Modal body -->
                                        <form action="" method="post">
                                            <div class="grid gap-4 mb-4 sm:grid-cols-2">
                                                <input name="_method" type="hidden" value="put"/>
                                                <input name="id" value="<%=task.getId()%>" type="hidden"/>
                                                <div>
                                                    <label for="title<%=task.getId()%>"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        title</label>
                                                    <input type="text" name="title" value="<%=task.getTitle()%>"
                                                           id="title<%=task.getId()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="Ex. Apple iMac 27&ldquo;">
                                                </div>
                                                <div>
                                                    <label for="description"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        name</label>
                                                    <input type="text" name="description"
                                                           value="<%=task.getDescription()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="">
                                                </div>
                                                <div>
                                                    <label for="due_date"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        name</label>
                                                    <input type="datetime-local" name="due_date"
                                                           value="<%=task.getDueDate()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="">
                                                </div>

                                                <%
                                                    if (authenticatedUser != null && authenticatedUser.getRole() == UserRole.MANAGER) {
                                                %>
                                                <div class="max-w-sm mx-auto">
                                                    <label for="countriesss"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Assigned
                                                        to</label>
                                                    <select id="countriesss" name="assigned_to"
                                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                                        <%
                                                            for (User user : users) {
                                                                if (authenticatedUser.getId() == user.getId())
                                                                    continue;
                                                        %>
                                                        <option value="<%= user.getId() %>"  <%= user.getId() == task.getAssignedTo().getId() ? "selected" : "" %> ><%= user.getUsername() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <%
                                                    }
                                                %>


                                                <div class="max-w-sm w-24 mx-auto">
                                                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">tags </label>

                                                    <select
                                                            id="selectTag<%=task.getId()%>"
                                                            name="tags[]"
                                                            multiple
                                                            placeholder="Select roles..."
                                                            autocomplete="off"
                                                            class="block w-full rounded-sm cursor-pointer focus:outline-none"
                                                    >
                                                        <%
                                                            for (Tag tag : tags) {
                                                        %>
                                                        <option value="<%= tag.getId() %>" <%= task.getTags().stream().filter(a -> a.getId() == tag.getId()).collect(Collectors.toList()).isEmpty() ? "" : "selected" %>><%= tag.getName() %>
                                                        </option>

                                                        <%
                                                            }
                                                        %>
                                                    </select>

                                                </div>

                                            </div>
                                            <div class="flex items-center space-x-4">
                                                <button type="submit"
                                                        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                                    Update Task
                                                </button>
                                                <button type="button"
                                                        class="text-red-600 inline-flex items-center hover:text-white border border-red-600 hover:bg-red-600 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                                                    <svg class="mr-1 -ml-1 w-5 h-5" fill="currentColor"
                                                         viewbox="0 0 20 20"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd"
                                                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                                              clip-rule="evenodd"></path>
                                                    </svg>
                                                    Delete
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <script>
                                $(document).ready(function () {
                                    $('#selectTag<%=task.getId()%>').select2();
                                });
                            </script>


                        </li>
                        <% } %>
                        <% if (authenticatedUser.getRole() == UserRole.MANAGER || task.getCreatedBy().getId() == authenticatedUser.getId()) { %>
                        <li>
                            <button type="button" data-modal-target="deleteModal<%=task.getId()%>"
                                    data-modal-toggle="deleteModal<%=task.getId()%>"
                                    class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 text-red-500 dark:hover:text-red-400">
                                <svg class="w-4 h-4 mr-2" viewbox="0 0 14 15" fill="none"
                                     xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path fill-rule="evenodd" clip-rule="evenodd" fill="currentColor"
                                          d="M6.09922 0.300781C5.93212 0.30087 5.76835 0.347476 5.62625 0.435378C5.48414 0.523281 5.36931 0.649009 5.29462 0.798481L4.64302 2.10078H1.59922C1.36052 2.10078 1.13161 2.1956 0.962823 2.36439C0.79404 2.53317 0.699219 2.76209 0.699219 3.00078C0.699219 3.23948 0.79404 3.46839 0.962823 3.63718C1.13161 3.80596 1.36052 3.90078 1.59922 3.90078V12.9008C1.59922 13.3782 1.78886 13.836 2.12643 14.1736C2.46399 14.5111 2.92183 14.7008 3.39922 14.7008H10.5992C11.0766 14.7008 11.5344 14.5111 11.872 14.1736C12.2096 13.836 12.3992 13.3782 12.3992 12.9008V3.90078C12.6379 3.90078 12.8668 3.80596 13.0356 3.63718C13.2044 3.46839 13.2992 3.23948 13.2992 3.00078C13.2992 2.76209 13.2044 2.53317 13.0356 2.36439C12.8668 2.1956 12.6379 2.10078 12.3992 2.10078H9.35542L8.70382 0.798481C8.62913 0.649009 8.5143 0.523281 8.37219 0.435378C8.23009 0.347476 8.06631 0.30087 7.89922 0.300781H6.09922ZM4.29922 5.70078C4.29922 5.46209 4.39404 5.23317 4.56282 5.06439C4.73161 4.8956 4.96052 4.80078 5.19922 4.80078C5.43791 4.80078 5.66683 4.8956 5.83561 5.06439C6.0044 5.23317 6.09922 5.46209 6.09922 5.70078V11.1008C6.09922 11.3395 6.0044 11.5684 5.83561 11.7372C5.66683 11.906 5.43791 12.0008 5.19922 12.0008C4.96052 12.0008 4.73161 11.906 4.56282 11.7372C4.39404 11.5684 4.29922 11.3395 4.29922 11.1008V5.70078ZM8.79922 4.80078C8.56052 4.80078 8.33161 4.8956 8.16282 5.06439C7.99404 5.23317 7.89922 5.46209 7.89922 5.70078V11.1008C7.89922 11.3395 7.99404 11.5684 8.16282 11.7372C8.33161 11.906 8.56052 12.0008 8.79922 12.0008C9.03791 12.0008 9.26683 11.906 9.43561 11.7372C9.6044 11.5684 9.69922 11.3395 9.69922 11.1008V5.70078C9.69922 5.46209 9.6044 5.23317 9.43561 5.06439C9.26683 4.8956 9.03791 4.80078 8.79922 4.80078Z"/>
                                </svg>
                                Delete
                            </button>
                        </li>

                        <div id="deleteModal<%=task.getId()%>" tabindex="-1" aria-hidden="true"
                             class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                            <div class="relative p-4 w-full max-w-md max-h-full">
                                <!-- Modal content -->
                                <div class="relative p-4 text-center bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
                                    <button type="button"
                                            class="text-gray-400 absolute top-2.5 right-2.5 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                            data-modal-toggle="deleteModal<%=task.getId()%>">
                                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd"
                                                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                  clip-rule="evenodd"/>
                                        </svg>
                                        <span class="sr-only">Close modal</span>
                                    </button>
                                    <svg class="text-gray-400 dark:text-gray-500 w-11 h-11 mb-3.5 mx-auto"
                                         aria-hidden="true" fill="currentColor" viewbox="0 0 20 20"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd"
                                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                              clip-rule="evenodd"/>
                                    </svg>
                                    <p class="mb-4 text-gray-500 dark:text-gray-300">Are you sure you want to delete
                                        this item?</p>
                                    <form class="flex justify-center items-center space-x-4" method="post">
                                        <input type="hidden" name="_method" value="delete">
                                        <input type="hidden" name="id" value="<%= task.getId() %>"/>
                                        <button type="button"
                                                class="py-2 px-3 text-sm font-medium text-gray-500 bg-white rounded-lg border border-gray-200 hover:bg-gray-100 focus:ring-4 focus:outline-none"
                                                onclick="closeModal('deleteModal<%= task.getId() %>')">No, cancel
                                        </button>
                                        <button type="submit"
                                                class="py-2 px-3 text-sm font-medium text-center text-white bg-red-600 rounded-lg hover:bg-red-700 focus:ring-4 focus:outline-none">
                                            Yes, I'm sure
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="px-4 py-4 mx-5 font-normal bg-gray-300 rounded-lg my-2 ">
                        <div class="flex flex-col justify-between md:flex-row">
                            <h3 class="mb-2 text-2xl font-semibold leading-snug">
                                <%=task.getTitle()%>
                            </h3>
                            <div class="flex items-center mb-2 space-x-2">
                                <% for (Tag tag : task.getTags()) { %>
                                <p class="px-2 text-gray-200 bg-blue-600 rounded"><%=tag.getName()%>
                                </p>
                                <% } %>
                            </div>
                        </div>
                        <p class="text-gray-700">
                            <%= task.getDescription()%>
                        </p>
                        <h2><%=task.getAssignedTo() != null ? task.getAssignedTo().getUsername() : "no one"%>
                        </h2>
                        <h2><%=task.getCreatedBy() != null ? task.getCreatedBy().getUsername() : "no one"%>
                        </h2>
                        <p><%=task.getCreatedAt()%>
                        </p>
                    </div>
                </ul>

                <% } %>
            </div>

            <div class="flex-1 bg-gray-200 p-4 rounded-lg shadow">
                <h2 class="text-xl font-semibold mb-4">Over due</h2>
                <% for (Task task : tasks.stream().filter((e) -> e.getStatus() == TaskStatus.OVERDUE).collect(Collectors.toList())) { %>

                <ul id="todo-list" class="min-h-[200px] my-2 bg-red-300 rounded-lg  space-y-2">
                    <div class="flex justify-end gap-5 ">

                        <% if (authenticatedUser.getRole() == UserRole.MANAGER || task.getCreatedBy().getId() == authenticatedUser.getId()) { %>


                        <li>
                            <button type="button" data-modal-target="<%= task.getId() %>"
                                    data-modal-toggle="<%= task.getId() %>"
                                    class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                                <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 20 20"
                                     fill="currentColor" aria-hidden="true">
                                    <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"/>
                                    <path fill-rule="evenodd" clip-rule="evenodd"
                                          d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"/>
                                </svg>
                                Edit
                            </button>

                            <div id="<%= task.getId() %>" tabindex="-1" aria-hidden="true"
                                 class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                                <div class="relative p-4 w-full max-w-2xl max-h-full">
                                    <!-- Modal content -->
                                    <div class="relative p-4 bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
                                        <!-- Modal header -->
                                        <div class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5 dark:border-gray-600">
                                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Update
                                                Product</h3>
                                            <button type="button"
                                                    class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                                    data-modal-toggle="<%= task.getId() %>">
                                                <svg aria-hidden="true" class="w-5 h-5" fill="currentColor"
                                                     viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd"
                                                          d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                          clip-rule="evenodd"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <!-- Modal body -->
                                        <form action="" method="post">
                                            <div class="grid gap-4 mb-4 sm:grid-cols-2">
                                                <input name="_method" type="hidden" value="put"/>
                                                <input name="id" value="<%=task.getId()%>" type="hidden"/>
                                                <div>
                                                    <label for="title<%=task.getId()%>"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        title</label>
                                                    <input type="text" name="title" value="<%=task.getTitle()%>"
                                                           id="title<%=task.getId()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="Ex. Apple iMac 27&ldquo;">
                                                </div>
                                                <div>
                                                    <label for="description"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        name</label>
                                                    <input type="text" name="description"
                                                           value="<%=task.getDescription()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="">
                                                </div>
                                                <div>
                                                    <label for="due_date"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                                        name</label>
                                                    <input type="datetime-local" name="due_date"
                                                           value="<%=task.getDueDate()%>"
                                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                           placeholder="">
                                                </div>

                                                <%
                                                    if (authenticatedUser != null && authenticatedUser.getRole() == UserRole.MANAGER) {
                                                %>
                                                <div class="max-w-sm mx-auto">
                                                    <label for="countries"
                                                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Assigned
                                                        to</label>
                                                    <select id="countries" name="assigned_to"
                                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                                        <%
                                                            for (User user : users) {
                                                                if (authenticatedUser.getId() == user.getId())
                                                                    continue;
                                                        %>
                                                        <option value="<%= user.getId() %>"  <%= user.getId() == task.getAssignedTo().getId() ? "selected" : "" %> ><%= user.getUsername() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <%
                                                    }
                                                %>


                                                <div class="max-w-sm w-24 mx-auto">
                                                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">tags </label>

                                                    <select
                                                            id="selectTag<%=task.getId()%>"
                                                            name="tags[]"
                                                            multiple
                                                            placeholder="Select roles..."
                                                            autocomplete="off"
                                                            class="block w-full rounded-sm cursor-pointer focus:outline-none"
                                                    >
                                                        <%
                                                            for (Tag tag : tags) {
                                                        %>
                                                        <option value="<%= tag.getId() %>" <%= task.getTags().stream().filter(a -> a.getId() == tag.getId()).collect(Collectors.toList()).isEmpty() ? "" : "selected" %>><%= tag.getName() %>
                                                        </option>

                                                        <%
                                                            }
                                                        %>
                                                    </select>

                                                </div>

                                            </div>
                                            <div class="flex items-center space-x-4">
                                                <button type="submit"
                                                        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                                    Update Task
                                                </button>
                                                <button type="button"
                                                        class="text-red-600 inline-flex items-center hover:text-white border border-red-600 hover:bg-red-600 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                                                    <svg class="mr-1 -ml-1 w-5 h-5" fill="currentColor"
                                                         viewbox="0 0 20 20"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd"
                                                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                                              clip-rule="evenodd"></path>
                                                    </svg>
                                                    Delete
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <script>
                                $(document).ready(function () {
                                    $('#selectTag<%=task.getId()%>').select2();
                                });
                            </script>


                        </li>
                        <% } %>
                        <% if (authenticatedUser.getRole() == UserRole.MANAGER || task.getCreatedBy().getId() == authenticatedUser.getId()) { %>
                        <li>
                            <button type="button" data-modal-target="deleteModal<%=task.getId()%>"
                                    data-modal-toggle="deleteModal<%=task.getId()%>"
                                    class="flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 text-red-500 dark:hover:text-red-400">
                                <svg class="w-4 h-4 mr-2" viewbox="0 0 14 15" fill="none"
                                     xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path fill-rule="evenodd" clip-rule="evenodd" fill="currentColor"
                                          d="M6.09922 0.300781C5.93212 0.30087 5.76835 0.347476 5.62625 0.435378C5.48414 0.523281 5.36931 0.649009 5.29462 0.798481L4.64302 2.10078H1.59922C1.36052 2.10078 1.13161 2.1956 0.962823 2.36439C0.79404 2.53317 0.699219 2.76209 0.699219 3.00078C0.699219 3.23948 0.79404 3.46839 0.962823 3.63718C1.13161 3.80596 1.36052 3.90078 1.59922 3.90078V12.9008C1.59922 13.3782 1.78886 13.836 2.12643 14.1736C2.46399 14.5111 2.92183 14.7008 3.39922 14.7008H10.5992C11.0766 14.7008 11.5344 14.5111 11.872 14.1736C12.2096 13.836 12.3992 13.3782 12.3992 12.9008V3.90078C12.6379 3.90078 12.8668 3.80596 13.0356 3.63718C13.2044 3.46839 13.2992 3.23948 13.2992 3.00078C13.2992 2.76209 13.2044 2.53317 13.0356 2.36439C12.8668 2.1956 12.6379 2.10078 12.3992 2.10078H9.35542L8.70382 0.798481C8.62913 0.649009 8.5143 0.523281 8.37219 0.435378C8.23009 0.347476 8.06631 0.30087 7.89922 0.300781H6.09922ZM4.29922 5.70078C4.29922 5.46209 4.39404 5.23317 4.56282 5.06439C4.73161 4.8956 4.96052 4.80078 5.19922 4.80078C5.43791 4.80078 5.66683 4.8956 5.83561 5.06439C6.0044 5.23317 6.09922 5.46209 6.09922 5.70078V11.1008C6.09922 11.3395 6.0044 11.5684 5.83561 11.7372C5.66683 11.906 5.43791 12.0008 5.19922 12.0008C4.96052 12.0008 4.73161 11.906 4.56282 11.7372C4.39404 11.5684 4.29922 11.3395 4.29922 11.1008V5.70078ZM8.79922 4.80078C8.56052 4.80078 8.33161 4.8956 8.16282 5.06439C7.99404 5.23317 7.89922 5.46209 7.89922 5.70078V11.1008C7.89922 11.3395 7.99404 11.5684 8.16282 11.7372C8.33161 11.906 8.56052 12.0008 8.79922 12.0008C9.03791 12.0008 9.26683 11.906 9.43561 11.7372C9.6044 11.5684 9.69922 11.3395 9.69922 11.1008V5.70078C9.69922 5.46209 9.6044 5.23317 9.43561 5.06439C9.26683 4.8956 9.03791 4.80078 8.79922 4.80078Z"/>
                                </svg>
                                Delete
                            </button>
                        </li>

                        <div id="deleteModal<%=task.getId()%>" tabindex="-1" aria-hidden="true"
                             class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                            <div class="relative p-4 w-full max-w-md max-h-full">
                                <!-- Modal content -->
                                <div class="relative p-4 text-center bg-white rounded-lg shadow dark:bg-gray-800 sm:p-5">
                                    <button type="button"
                                            class="text-gray-400 absolute top-2.5 right-2.5 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                                            data-modal-toggle="deleteModal<%=task.getId()%>">
                                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd"
                                                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                  clip-rule="evenodd"/>
                                        </svg>
                                        <span class="sr-only">Close modal</span>
                                    </button>
                                    <svg class="text-gray-400 dark:text-gray-500 w-11 h-11 mb-3.5 mx-auto"
                                         aria-hidden="true" fill="currentColor" viewbox="0 0 20 20"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd"
                                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                              clip-rule="evenodd"/>
                                    </svg>
                                    <p class="mb-4 text-gray-500 dark:text-gray-300">Are you sure you want to delete
                                        this item?</p>
                                    <form class="flex justify-center items-center space-x-4" method="post">
                                        <input type="hidden" name="_method" value="delete">
                                        <input type="hidden" name="id" value="<%= task.getId() %>"/>
                                        <button type="button"
                                                class="py-2 px-3 text-sm font-medium text-gray-500 bg-white rounded-lg border border-gray-200 hover:bg-gray-100 focus:ring-4 focus:outline-none"
                                                onclick="closeModal('deleteModal<%= task.getId() %>')">No, cancel
                                        </button>
                                        <button type="submit"
                                                class="py-2 px-3 text-sm font-medium text-center text-white bg-red-600 rounded-lg hover:bg-red-700 focus:ring-4 focus:outline-none">
                                            Yes, I'm sure
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="px-4 py-4 mx-5 font-normal bg-gray-300 rounded-lg my-2 ">
                        <div class="flex flex-col justify-between md:flex-row">
                            <h3 class="mb-2 text-2xl font-semibold leading-snug">
                                <%=task.getTitle()%>
                            </h3>
                            <div class="flex items-center mb-2 space-x-2">
                                <% for (Tag tag : task.getTags()) { %>
                                <p class="px-2 text-gray-200 bg-blue-600 rounded"><%=tag.getName()%>
                                </p>
                                <% } %>
                            </div>
                        </div>
                        <p class="text-gray-700">
                            <%= task.getDescription()%>
                        </p>
                        <h2><%=task.getAssignedTo() != null ? task.getAssignedTo().getUsername() : "no one"%>
                        </h2>
                        <h2><%=task.getCreatedBy() != null ? task.getCreatedBy().getUsername() : "no one"%>
                        </h2>
                        <p><%=task.getCreatedAt()%>
                        </p>
                    </div>
                </ul>
                <% } %>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#selectTag').select2();
    });
</script>