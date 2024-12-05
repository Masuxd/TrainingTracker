# TrainingTracker
School project at TAMK


Training tracker is an application designed for workout tracking and training planning

Running demo:

Frontend: folder /builds contains frontend.exe that can be used for testing frontend

Backend: API is hosted on https://www.trainintracker.space

Test credentials for loggin in:

Email: test@test.local

Password: Salasana123!

optionally:

Flutter can be run by using "flutter run" in /frontend   -   Requires flutter SDK to be installed

Running backend locally can be done by using "docker-compose up --build" in root folder   -   requires docker to be installed. Must change api url in /frontend/lib/commmon/services/api/api_client.dart to "https://localhost:3000" to run project locally. this hasnt been tested in a while since last commits were tested directly on hosted API

