SELECT
     ����       = Case When A.colorder=1 Then D.name Else '' End,
     ��˵��     = Case When A.colorder=1 Then isnull(F.value,'') Else '' End,
     �ֶ����   = A.colorder,
     �ֶ���     = A.name,
     �ֶ�˵��   = isnull(G.[value],''),
     ��ʶ       = Case When COLUMNPROPERTY( A.id,A.name,'IsIdentity')=1 Then '��'Else '' End,
     ����       = Case When exists(SELECT 1 FROM sysobjects Where xtype='PK' and parent_obj=A.id and name in (
                      SELECT name FROM sysindexes WHERE indid in( SELECT indid FROM sysindexkeys WHERE id = A.id AND colid=A.colid))) then '��' else '' end,
     ����       = B.name,
     ռ���ֽ��� = A.Length,
     ����       = COLUMNPROPERTY(A.id,A.name,'PRECISION'),
     С��λ��   = isnull(COLUMNPROPERTY(A.id,A.name,'Scale'),0),
     �����     = Case When A.isnullable=1 Then '��'Else '' End,
     Ĭ��ֵ     = isnull(E.Text,'')
 FROM
     syscolumns A
 Left Join
     systypes B
 On
     A.xusertype=B.xusertype
 Inner Join
     sysobjects D
 On
     A.id=D.id  and D.xtype='U' and  D.name<>'dtproperties'--���ݿ���
 Left Join
     syscomments E
 on
     A.cdefault=E.id
 Left Join
 sys.extended_properties  G
 on
     A.id=G.major_id and A.colid=G.minor_id
 Left Join

 sys.extended_properties F
 On
     D.id=F.major_id and F.minor_id=0
     --where d.name='OrderInfo'    --���ֻ��ѯָ����,���ϴ�����
 Order By
     A.id,A.colorder