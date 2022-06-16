from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from activityapp.api.serializers import ActivitySerializer
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework import status
from activityapp.models import Activity
from rest_framework.generics import ListAPIView
from rest_framework.authentication import TokenAuthentication


@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def create_activity_view(request):
    account = request.user
    activity = Activity(user=account)

    if request.method == "POST":
        serializer = ActivitySerializer(activity, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        print(serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ListActivityView(ListAPIView):
    serializer_class = ActivitySerializer
    authentication_classes = (TokenAuthentication, )
    permission_classes = (IsAuthenticated, )
    def get_queryset(self):
        username = self.kwargs['slug']
        queryset = Activity.objects.all().filter(username=username)
        queryset.order_by('-date')
        return queryset