
select * from org.ApplicationCommands

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/', 'DaadkhaiApp', N'سامانه دادخواهی عالی مالیاتی')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/1/', 'BaseInfo', N'اطلاعات پایه')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/1/1/', 'profile', N'مشخصات کاربر')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/1/2/', 'tax-office-list', N'فهرست ادارات کل مالیاتی')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/1/2/1/', 'tax-office', N'افزودن اداره کل مالیاتی')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/2/', 'Requests', N'عملیات سامانه')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/2/1/', 'Complaint', N'ثبت شکوائیه جدید')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/2/2/', 'ComplaintCartable', N'کارتابل شکوائیه‌ها')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/2/3/', 'MinisterCartable', N'لیست وزیر')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/2/4/', 'InputLetterList', N'نامه‌های وارده')

insert into org.ApplicationCommands (ID, ApplicationID, [Node], [Name], Title)
values (NEWID(), '2AC51699-9656-4060-B632-B85E4AF705BA', '/1/2/4/1/', 'AddInputLetter', N'ثبت نامه وارده')

