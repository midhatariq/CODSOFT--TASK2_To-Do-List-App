# CODSOFT--TASK2_To-Do-List-App


Just completed a task for my internship! Check out the video to see what I accomplished and excited for more opportunities.
hashtag#codsoftinternship hashtag#flutterinternship hashtag#codsoft CodSoft

This Flutter application is for managing a task list. It consists of several classes and widgets to create, edit, and delete task. At the entry point of the application, the `main()` function calls `runApp()` and passes an instance of the `TaskListApp` class, which is the root widget of the application.The `TaskListApp` class configures the overall theme of the app using `MaterialApp`, including the title and primary color. Additionally, it sets the status bar color to transparent to achieve a seamless look.
The home screen of the app is represented by the `TaskListScreen` class, which is a StatefulWidget. It maintains a list of tasks and displays them using a ListView. Each task is displayed as a ListTile with a title, checkbox to mark completion, and a tap gesture to edit the task.
The `CreateTaskScreen` class is used to create a new task. It provides a text field for entering the task title and a button to save the task. Upon saving, the task is added to the list of tasks.The `EditTaskScreen` class allows users to edit existing tasks. It displays the task title in a text field and a checkbox to toggle completion status. Users can save the edited task or delete it altogether.Overall, the application provides a user-friendly interface for managing tasks, including adding, editing, and deleting tasks efficiently
