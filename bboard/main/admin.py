from django.contrib import admin
import datetime
from .models import AdvUser
from .utilities import send_activation_notification

def send_activation_notifications(modeladmin,request, queryset):
    for rec in queryset:
        if not rec.is_activated:
            send_activation_notification(rec)
    modeladmin.message_user(request,'Письма с оповещением отправлены')
    send_activation_notifications.short_description = 'Отправка писем с ' + \
            'оповещениями об активации'

class NonactivatedFilter(admin.SimpleListFilter):
   title = 'Прошли активацию?'
   parameter_name = 'actstate'

   def lookups(self, request, modeladmin):
       return (
           ('activated','Прошли'),
           ('threedays','Не прошли более 3 дней'),
           ('week','Не прошли более недели'),
           )

def queryset(self, request, queryset):
    val = self.value()
    if val == 'activated':
        d = datetime.date.today() - datetime.timedelta(weeks=1)
        return queryset.filter(is_active=False, is_activated=False, date_joined__date__lt=d)

class AdvUserAdmin(admin.ModelAdmin):
    list_display = ('__str__', 'is_activated', 'date_joined')
    search_fields = ('username', 'email', 'first_name', 'last_name')
    list_filter = (NonactivatedFilter,)
    filds = (('username','email'),('first_name','last_name'),
             ('send_messages','is_active','is_activated'),
             ('is_staff','is_superuser'),
             'groups', 'user_permissions',
             ('last_login', 'date_joined'))
    readonly_fields = ('last_login', 'date_joined')
    actions = (send_activation_notifications,)



admin.site.register(AdvUser)
