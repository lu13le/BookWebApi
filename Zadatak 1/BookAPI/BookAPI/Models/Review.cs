using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookAPI.Models
{
    public class Review
    {
        //properties
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Required]
        [StringLength(200, MinimumLength = 10, ErrorMessage = "Headline needs to be between 10 and 200 characters ")]
        public string HeadLine { get; set; }
        [Required]
        [StringLength(2000, MinimumLength = 50, ErrorMessage = "Headline needs to be between 50 and 2000 characters ")]
        public string ReviewText { get; set; }
        [Required]
        [Range(1,5,ErrorMessage ="Rating must be between 1 and 5 stars")]
        public int Rating { get; set; }

        //representing relations between tables
        public virtual Reviewer Reviewer { get; set; }
        public virtual Book Book{ get; set; }
    }
}
 