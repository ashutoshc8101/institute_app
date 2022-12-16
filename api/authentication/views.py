import json
import os
from pathlib import Path
from authentication.models import Staff, StaffToken, User, UserToken
from authentication.serializers import StaffSerializer, UserSerializer
from rest_framework.response import Response
from rest_framework.views import APIView

from django.contrib.auth.hashers import check_password
from google.auth.transport import requests
from google.oauth2 import id_token
from rest_framework import exceptions

import environ

env = environ.Env()

# Set the project base directory
BASE_DIR = Path(__file__).resolve().parent.parent

# Take environment variables from .env file
environ.Env.read_env(os.path.join(BASE_DIR.parent, '.env'))

class ObtainIdTokenView(APIView):
    permission_classes = []

    def post(self, request):
        credentials = json.loads(request.body.decode('utf-8'))
        idToken = credentials.get('idToken')

        if not idToken:
            return Response(status=400, data='idToken field is empty')

        try:
            decoded_token = id_token.verify_oauth2_token(
                idToken, requests.Request(), env('GOOGLE_OAUTH_CLIENT_ID'))
        except Exception:
            raise exceptions.AuthenticationFailed('Invalid ID Token')

        try:
            email = decoded_token.get("email")
            first_name = decoded_token.get("given_name").capitalize()
            last_name = decoded_token.get("family_name").capitalize()

        except Exception:
            raise exceptions.AuthenticationFailed('No such user exists')

        user, _ = User.objects.get_or_create(email=email, first_name = first_name, last_name = last_name)

        token, _ = UserToken.objects.get_or_create(user=user)

        askForDetails = True

        if user.profile:
            askForDetails = False

        return Response(status = 200, data = {
            'idToken': token.key,
            'askForDetails': askForDetails,
            'user': UserSerializer(user).data
        })



class ObtainStaffTokenView(APIView):
    permission_classes = []

    def post(self, request, *args, **kwargs):
        credentials = json.loads(request.body.decode('utf-8'))
        username = credentials.get('username')
        raw_password = credentials.get('password')

        if not username or not raw_password:
            return Response(status=400, data='Username and password fields are empty')

        staff_user = Staff.objects.get(username=username)

        if check_password(raw_password, staff_user.password):
            token, _ = StaffToken.objects.get_or_create(user=staff_user)
            return Response({'token': token.key, 'staff_user': StaffSerializer(staff_user).data})

        return Response(status=401, data='Authentication credentials are incorrect')
