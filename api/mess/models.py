from institute_app import settings
from django.db import models


class MenuItem(models.Model):
    name = models.CharField(max_length=30, default='')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class MenuSlot(models.Model):
    name = models.CharField(max_length=15, default='')
    start_time = models.TimeField()
    end_time = models.TimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class WeekDay(models.Model):
    name = models.CharField(max_length=15, default='')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Mess(models.Model):
    name = models.CharField(max_length=15, default='')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class MessMenu(models.Model):
    slot = models.ForeignKey(MenuSlot, on_delete=models.CASCADE)
    items = models.ManyToManyField(MenuItem)
    weekdays = models.ManyToManyField(WeekDay)

# data base model for feedback
# status is for whether the feedback is viewed by mess manager or not.


class MessFeedback(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             on_delete=models.CASCADE)
    body = models.TextField(editable=True, null=False, blank=True)
    mess_meal = models.CharField(max_length=50)
    mess_type = models.ForeignKey(Mess, on_delete=models.CASCADE, null=True)
    created_at = models.DateTimeField(auto_now=True)
    status = models.BooleanField(default=False)


class MessComplaint(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             on_delete=models.CASCADE)
    body = models.TextField(editable=True, null=False, blank=True)
    mess_meal = models.CharField(max_length=50)
    mess_type = models.ForeignKey(Mess, on_delete=models.CASCADE, null=True)
    file = models.FileField(upload_to='complaints/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now=True)
    status = models.BooleanField(default=False)

# data base model for mess mom


class MessMom(models.Model):
    date = models.DateField(default=None, null=True)
    file = models.FileField(upload_to='mom/')
    title = models.CharField(max_length=100)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now=True)

# data base model for mess tender


class MessTender(models.Model):
    archieved = models.BooleanField(default=False)
    date = models.DateField(default=None, null=True)
    contractor = models.CharField(max_length=100)
    file = models.FileField(upload_to='tender/')
    title = models.CharField(max_length=100)
    description = models.TextField(null=True)
    created_at = models.DateTimeField(auto_now=True)
