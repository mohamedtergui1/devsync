<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="org.example.entity.Tag" %>
<div class="bg-white py-24 sm:py-32">
    <div class="mx-auto max-w-7xl px-6 lg:px-8">
        <div class="mx-auto max-w-2xl lg:max-w-none">
            <% Map<String,Long> counts =  request.getAttribute("counts") != null ? (Map<String, Long>) request.getAttribute("counts") : new HashMap<>();%>
            <div class="text-center">
                <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Empowering Businesses Globally</h2>
                <p class="mt-4 text-lg leading-8 text-gray-600">
                    Our platform is trusted by organizations worldwide to boost productivity, streamline operations, and enhance
                    customer experiences.
                </p>
            </div>
            <dl class="mt-16 grid grid-cols-1 gap-0.5 overflow-hidden rounded-2xl text-center sm:grid-cols-2 lg:grid-cols-4">
                <div class="flex flex-col bg-gray-200/50 p-8">
                    <dt class="text-sm font-semibold leading-6 text-gray-600">Active Users</dt>
                    <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900"><%=counts.get("usersCount")%></dd>
                </div>
                <div class="flex flex-col bg-gray-200/50 p-8">
                    <dt class="text-sm font-semibold leading-6 text-gray-600">Total Tags</dt>
                    <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900"><%=counts.get("tagsCount")%></dd>
                </div>
                <div class="flex flex-col bg-gray-200/50 p-8">
                    <dt class="text-sm font-semibold leading-6 text-gray-600">Total tasks</dt>
                    <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900"><%=counts.get("tasksCount")%></dd>
                </div>
                <div class="flex flex-col bg-gray-200/50 p-8">
                    <dt class="text-sm font-semibold leading-6 text-gray-600">Happy Customers</dt>
                    <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900">98%</dd>
                </div>
            </dl>
        </div>
    </div>
</div>


<script>
    const fetchData = () => {
        fetch("/statistic").then(response => response.json()).then(response => {
            console.log(response)
        })
    }
</script>