/****** Object:  StoredProcedure [dbo].[sp_list_schedule_job]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_schedule_job]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_schedule_job]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



Create    PROCEDURE [dbo].[sp_list_schedule_job] 

 

 

 

AS

 

BEGIN


SELECT 

     [sJOB].[name] AS [JobName]

    , CASE 

        WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL

        ELSE CAST(

                CAST([sJOBH].[run_date] AS CHAR(8))

                + ' ' 

                + STUFF(

                    STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)

                        , 3, 0, ':')

                    , 6, 0, ':')

                AS DATETIME)

      END AS [LastRunDateTime],


                  CASE 

        WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL

        ELSE dateadd( second,

                                case when [sJOBH].[run_duration] is null then 0 else

                                case when len([sJOBH].[run_duration]) <= 2  then [sJOBH].[run_duration]

                                else right([sJOBH].[run_duration], 2) end 

                                end        ,

                                

                                dateadd( minute,

                 case when [sJOBH].[run_duration] is null then 0 else

                                case when len([sJOBH].[run_duration]) <= 2  then 0

                                else left([sJOBH].[run_duration],len([sJOBH].[run_duration])-2) end 

                                end        ,

 

                                CAST(

                CAST([sJOBH].[run_date] AS CHAR(8))

                + ' ' 

                + STUFF(

                    STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)

                        , 3, 0, ':')

                    , 6, 0, ':')

                AS DATETIME)

                                                                ) 

 

                                                                )

      END  AS [LastRunEndDateTime],

 

   CASE [sJOBH].[run_status]

        WHEN 0 THEN 'Failed'

        WHEN 1 THEN 'Succeeded'

        WHEN 2 THEN 'Retry'

        WHEN 3 THEN 'Canceled'

        WHEN 4 THEN 'Running' -- In Progress

      END AS [LastRunStatus]

    , STUFF(

            STUFF(RIGHT('000000' + CAST([sJOBH].[run_duration] AS VARCHAR(6)),  6)

                , 3, 0, ':')

            , 6, 0, ':') 

        AS [LastRunDuration (HH:MM:SS)]

    , [sJOBH].[message] AS [LastRunStatusMessage]

    , CASE [sJOBSCH].[NextRunDate]

        WHEN 0 THEN NULL

        ELSE CAST(

                CAST([sJOBSCH].[NextRunDate] AS CHAR(8))

                + ' ' 

                + STUFF(

                    STUFF(RIGHT('000000' + CAST([sJOBSCH].[NextRunTime] AS VARCHAR(6)),  6)

                        , 3, 0, ':')

                    , 6, 0, ':')

                AS DATETIME)

      END AS [NextRunDateTime] 

FROM 

    [msdb].[dbo].[sysjobs] AS [sJOB]

    LEFT JOIN (

                SELECT

                    [job_id]

                    , MIN([next_run_date]) AS [NextRunDate]

                    , MIN([next_run_time]) AS [NextRunTime]

                FROM [msdb].[dbo].[sysjobschedules]

                GROUP BY [job_id]

            ) AS [sJOBSCH]

        ON [sJOB].[job_id] = [sJOBSCH].[job_id]

    LEFT JOIN (

                SELECT 

                    [job_id]

                    , [run_date]

                    , [run_time]

                    , [run_status]

                    , [run_duration]

                    , [message]

                    , ROW_NUMBER() OVER (

                                            PARTITION BY [job_id] 

                                            ORDER BY [run_date] DESC, [run_time] DESC

                      ) AS RowNumber

                FROM [msdb].[dbo].[sysjobhistory]

                WHERE [step_id] = 0

            ) AS [sJOBH]

        ON [sJOB].[job_id] = [sJOBH].[job_id]

        AND [sJOBH].[RowNumber] = 1

ORDER BY [JobName]


 

END

 


GO
GRANT EXECUTE ON [dbo].[sp_list_schedule_job] TO [ERPUSER] AS [dbo]
GO
