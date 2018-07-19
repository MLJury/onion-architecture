using System;
using System.Collections.Concurrent;

namespace Kama.Mefa.Azmoon.API.Auth
{
		public enum AzmoonCommands : short
		{
							fafa = 0,
					BaseInfo = 1,
					tax_office = 2,
					Complaint = 3,
					AddInputLetter = 4,
					DaadkhaiApp = 5,
					Requests = 6,
					MinisterCartable = 7,
					Sdadasda = 8,
					profile = 9,
					InputLetterList = 10,
			}
		public static class commandDic
		{
			private static ConcurrentDictionary<AzmoonCommands, Guid> _cmdDic { get; set; }

		public static Guid getCmdId(AzmoonCommands azmCommand)
		{
		_cmdDic = new ConcurrentDictionary<AzmoonCommands, Guid>()
		{
					[AzmoonCommands.fafa] = new Guid("8554a17e-6479-45d5-9a0b-be8e845e8aa2"),
					[AzmoonCommands.BaseInfo] = new Guid("526c94ca-c186-4f60-a7a4-396c806eb0c2"),
					[AzmoonCommands.tax_office] = new Guid("10041a34-ba1f-4667-a1e2-ce03af882da2"),
					[AzmoonCommands.Complaint] = new Guid("b742e7f7-55aa-4314-859e-b7121676c820"),
					[AzmoonCommands.AddInputLetter] = new Guid("36ab028d-bbf1-4ed6-84a3-322935e30139"),
					[AzmoonCommands.DaadkhaiApp] = new Guid("a1fe8c25-68da-4310-bc2b-0039ce23eb4c"),
					[AzmoonCommands.Requests] = new Guid("4a6bd7b5-5397-4dc7-8aa7-a6fa49b1128c"),
					[AzmoonCommands.MinisterCartable] = new Guid("b68ede73-56c0-4b75-b22b-d368d00d402f"),
					[AzmoonCommands.Sdadasda] = new Guid("ff1654c6-8bee-4a6d-8a19-cbc57f1a71fb"),
					[AzmoonCommands.profile] = new Guid("2faefc3b-06e6-4e2b-af6f-58a5783fe886"),
					[AzmoonCommands.InputLetterList] = new Guid("7b7c728e-b506-4c96-9b17-1ac50f1c9558"),
		};

			return _cmdDic[azmCommand];
		}
	}
}
